Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277885AbRJORWJ>; Mon, 15 Oct 2001 13:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278037AbRJORWA>; Mon, 15 Oct 2001 13:22:00 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:40674 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277885AbRJORVs>; Mon, 15 Oct 2001 13:21:48 -0400
Date: Mon, 15 Oct 2001 10:24:26 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: <CARL.P.HIRSCH@sargentlundy.com>
cc: <larsi@gnus.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Bootp Timeout Problem
In-Reply-To: <OF6348277C.08D3A202-ON86256AE6.005B78B3@sargentlundy.com>
Message-ID: <Pine.LNX.4.33.0110151019160.32726-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 CARL.P.HIRSCH@sargentlundy.com wrote:

> Lars - I came across the message below while searching to a solution for a
> DHCP timeout issue. I'm fairly certain that this fix is relevant to the
> problem I'm investigating. We're working with a floppy linux distro that
> Novell created for imaging Novell workstations and I hope to apply this
> patch to the floppy distro to see if it is the fix we're looking for (we
> suspect Spantree Portfast on Cisco Catalyst3524XLs is tripping up DHCP
> acquisition)..
>
> I'm a bit of a linux newbie - does this involve editing the ifconfig.c file

yeah it will require a kernel rebuild...

assuming you have a kernel tree someplace for this mini distro (for
example in /usr/src/linux) you'd need to apply the patch to the file
/usr/src/linux/net/ipv4/ipconfig.c then rebuild the kernel...

regards
joelja

> only, or is a recompile or any components (or even the kernel?)  required
> to cause the change to take effect? If so, I expect the various FAQs can
> walk me through the actual procedure.
>
> LKML - apologies if this is off-topic, please reply off-list or CC me.
>
> thanks much,
> -carl hirsch
> network analyst
>
> From: Lars Magne Ingebrigtsen (larsi@gnus.org)
> Date: Sat Jul 29 2000 - 06:16:33 EST
>      Next message: Adam Sampson: "Re: sysconf (was Re: RLIM_INFINITY
>      inconsistency between archs)"
>      Previous message: Amit D Chaudhary: "Re: NFSv4 ACLs (was: ...ACL's and
>      reiser...)"
>      Next in thread: Fred Reimer: "Re: 2.2.16 bootp timeout problem
>      (patch)"
>      Reply: Fred Reimer: "Re: 2.2.16 bootp timeout problem (patch)"
>      Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
>
>
>
> The Cisco Catalyst 3500 switch has what seems like a training period
> of about ten seconds. Therefore, the default 3*2 second waiting
> period between card resets is too small to allow a Linux bootp client
> to boot through one of these switches.
>
>
> The following micro-patch just increases the CONF_SEND_RETRIES (which
> says how many bootp packets to send out between reopening the device(s))
> from 3 to 10, which fixes the problem.
>
>
> --- ipconfig.c~ Wed Jun 7 23:26:44 2000
> +++ ipconfig.c Sat Jul 29 12:53:18 2000
> @@ -75,7 +75,7 @@
>
>
>  /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
>  #define CONF_OPEN_RETRIES 3 /* (Re)open devices three times */
> -#define CONF_SEND_RETRIES 3 /* Send requests three times */
> +#define CONF_SEND_RETRIES 10 /* Send requests ten times */
>  #define CONF_BASE_TIMEOUT (HZ*2) /* Initial timeout: 2 seconds */
>  #define CONF_TIMEOUT_RANDOM (HZ) /* Maximum amount of randomization */
>  #define CONF_TIMEOUT_MULT *7/4 /* Rate of timeout growth */
>
>
> --
> (domestic pets only, the antidote for overdose, milk.)
>    larsi@gnus.org * Lars Magne Ingebrigtsen
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


