Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbTAGLVz>; Tue, 7 Jan 2003 06:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267044AbTAGLVy>; Tue, 7 Jan 2003 06:21:54 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:44740 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267027AbTAGLVx>; Tue, 7 Jan 2003 06:21:53 -0500
Date: Wed, 08 Jan 2003 00:24:24 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <2340000.1041938664@localhost.localdomain>
In-Reply-To: <20030107042045.GA10045@waste.org>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
 <3E19B401.7A9E47D5@linux-m68k.org>
 <17360000.1041899978@localhost.localdomain>
 <20030107042045.GA10045@waste.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No no, that's a 1% chance that one packet in the terabyte is broken.

But actually, it's not that hard to construct a peturbation to the packet 
that will beat both the ethernet and TCP checksums (I gave an example that 
beats TCP before).  That kind of change is not likely for random bit 
errors, but is quite likely to occur in just slightly marginal hardware. 
Partial packet duplication or byte reordering on the highly ordered data 
patterns you find in filesystem metadata could be really bad.

Like I say, debugging one crypto protocol I've seen this happen for real. 
Twice in about 10000 packets, on an otherwise apparently perfectly fine 
LAN.  I suspect bad cabling, and changed it, but it's hard to tell that 
anything has changed.  That shows that my 1% is probably quite conservative 
for that particular link.

Internet protocols (changing to IETF hat now) are supposed to work on the 
global internet, and that means iSCSI has to be engineered to work on the 
worst links imaginable, because sometime, somewhere, someone's data is 
going to cross a really broken backup link that they have no way of knowing 
has just come on.  Possibly it's wireless, where packet corruption due to 
undetected collisions happens quite frequently.

Andre routinely tests it with the IBM team in Israel, with his end in 
California.

Andrew

--On Monday, January 06, 2003 22:20:46 -0600 Oliver Xymoron 
<oxymoron@waste.org> wrote:

> On Tue, Jan 07, 2003 at 01:39:38PM +1300, Andrew McGregor wrote:
>> Hmm.  The problem here is that there is a nontrivial probability that a
>> packet can pass both ethernet and TCP checksums and still not be right,
>> given the gigantic volumes of data that iSCSI is intended to be used
>> with.  Back up a 100 terabyte array and it's more than 1%, back of the
>> envelope.
>
> What was the underlying error rate and distribution you assumed? I
> figure if it were high enough to get to your 1%, you'd have such high
> retry rates (and resulting throughput loss) that the operator would
> notice his LAN was broken weeks before said transfer completed.
>
> --
>  "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
>
>


