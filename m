Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDPLWm>; Mon, 16 Apr 2001 07:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRDPLWW>; Mon, 16 Apr 2001 07:22:22 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:64785 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S130768AbRDPLWT>;
	Mon, 16 Apr 2001 07:22:19 -0400
Date: Mon, 16 Apr 2001 13:21:10 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: David Findlay <david_j_findlay@yahoo.com.au>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010416132109.C29398@kallisto.sind-doof.de>
Mail-Followup-To: David Findlay <david_j_findlay@yahoo.com.au>,
	"Mike A. Harris" <mharris@opensourceadvocate.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041708461209.00352@workshop>; from david_j_findlay@yahoo.com.au on Tue, Apr 17, 2001 at 08:46:12AM +1000
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 17, 2001 at 08:46:12AM +1000, David Findlay wrote:
> 
> I suppose, but it would be so much easier if the kernel did it automatically. 
> Having a rule to go through for each IP address to be logged would be slower 
> than implementing one rule that would log all of them. Doing this in the 
> kernel would improve preformance.

You can use the iptables ULOG facility (see netfilter CVS for the
patches). With this you can copy packets to userspace programs which
can do any further processing, like the accounting stuff. You can even
choose to only copy part of a packet (say only the IP header) to
userspace, to reduce the amount of data your application has to
handle.

Simply copy the headers of all IP packets going through your router to
userspace, and write a small application (possibly using libipulog
which comes with the netfilter userspace code) which does the actual
accounting. This has the additional benefit that further processing of
the packet in kernel (i.e. outputting it on the destination interface)
can continue while your application is processing the accounting data.

Andreas
-- 
You are in a maze of little twisting passages, all alike.

