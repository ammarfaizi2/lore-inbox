Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpLRSV3TVYnr/QJanN0Ki6UV3Iw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 13:57:35 +0000
Message-ID: <02f601c415a4$b4527860$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:44:21 +0100
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: <Administrator@smtp.paston.co.uk>
Cc: "Andrew Morton" <akpm@osdl.org>, <daniel@osdl.org>, <janetmor@us.ibm.com>,
        <pbadari@us.ibm.com>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
In-Reply-To: <20040102055020.GA3410@in.ibm.com>
References: <20031231091828.GA4012@in.ibm.com> <20031231013521.79920efd.akpm@osdl.org> <20031231095503.GA4069@in.ibm.com> <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com> <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com> <20031231025309.6bc8ca20.akpm@osdl.org> <20031231025410.699a3317.akpm@osdl.org> <20031231031736.0416808f.akpm@osdl.org> <20040102055020.GA3410@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:21.0921 (UTC) FILETIME=[B46F0110:01C415A4]



On Fri, 2 Jan 2004, Suparna Bhattacharya wrote:

> On Wed, Dec 31, 2003 at 03:17:36AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Let me actually think about this a bit.
> >
> > Nasty.  The same race is present in 2.4.x...

filemap_fdatawait() is always called with i_sem held and
there is no "!PG_dirty and !PG_writeback" window.

Where does the race lies in 2.4 ?

Daniel, Would be interesting to know if the direct IO tests also fail on
2.4.

> > How's about we start new I/O in filemap_fdatawait() if the page is
> > dirty?
