Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpN+g3kAo+ZVuSJCr06rJI053Ig==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 22:46:22 +0000
Message-ID: <03dd01c415a4$dfa0e560$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:45:34 +0100
From: "Matthew Dobson" <colpatch@us.ibm.com>
Reply-To: <colpatch@us.ibm.com>
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
        <mbligh@aracnet.com>
Subject: Re: [PATCH] Simplify node/zone field in page->flags
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com> <20040105213736.GA19859@sgi.com>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:36.0578 (UTC) FILETIME=[E0EEC220:01C415A4]

Jesse Barnes wrote:
> On Mon, Jan 05, 2004 at 01:22:57PM -0800, Matthew Dobson wrote:
> 
>>Jesse had acked the patch in an earlier itteration.  The only thing 
>>that's changed is some line offsets whilst porting the patch forward.
>>
>>Jesse (or anyone else?), any objections to this patch as a superset of 
>>yours?
> 
> 
> No objections here.  Of course, you'll have to rediff against the
> current tree since that stuff has been merged for awhile now.  On a
> somewhat related note, Martin mentioned that he'd like to get rid of
> memblks.  I'm all for that too; they just seem to get in the way.
> 
> Jesse

Here's an updated version against 2.6.1-rc1.  Small comment fix (there 
are actually up to (MAX_NUMNODES * MAX_NR_ZONES) possible zones total, 
not log2(MAX_NUMNODES * MAX_NR_ZONES) as your comment stated.  That is 
the number of bits necessary to index every possible zone.

After this goes in, we (I) can convert a number of places that are doing 
several pointer dereferences/arithmetic and other things to determine 
which node/zone a page belongs to simply calling 
page_nodenum()/page_zonenum().

Cheers!

-Matt

