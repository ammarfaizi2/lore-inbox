Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2U11>; Mon, 29 Jan 2001 15:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRA2U1Q>; Mon, 29 Jan 2001 15:27:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:51209 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129101AbRA2U1K>; Mon, 29 Jan 2001 15:27:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: dcinege@psychosis.com, mingo@redhat.com
Date: Tue, 30 Jan 2001 07:26:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14965.53759.893603.65327@notabene.cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove arbitrary md= boot device limit
In-Reply-To: message from Dave Cinege on Monday January 29
In-Reply-To: <3A755950.9C730B80@psychosis.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 29, dcinege@psychosis.com wrote:
> linux-2.4.1p11-1/drivers/md/md.c
> line 3643
> -#define MAX_MD_BOOT_DEVS     8
> +#define MAX_MD_BOOT_DEVS     MAX_MD_DEVS
> 
> -------------------------------------------------------
> To:  Dave Cinege <dcinege@psychosis.com>
> 
> On Mon, 29 Jan 2001, Dave Cinege wrote:
> 
> > -#define MAX_MD_BOOT_DEVS     8
> > +#define MAX_MD_BOOT_DEVS     MAX_MD_DEVS
> 
> sure this is fine.
> 
>         Ingo

Actually, this is not fine.  Check the code that says:

	if (minor >= MAX_MD_BOOT_DEVS) {
		printk ("md: Minor device number too high.\n");
		return 0;
	} else if (md_setup_args.set & (1 << minor)) {
		printk ("md: Warning - md=%d,... has been specified twice;\n"
			"    will discard the first definition.\n", minor);
	}
     ..........
	md_setup_args.set |= (1 << minor);


Note that "md_setup_args.set" is an unsigned long.
If minor >= 32, then we wont successfully set a bit in the set, and
things wont work right.

NeilBrown


> -------------------------------------------------------
> To:	Ingo Molnar <mingo@redhat.com>
> 
> Devices above md8 will not be initialized when speced with md=.
> Error ("md: Minor device number too high.\n");
> 
> The limitation is imposed by
>         #define MAX_MD_BOOT_DEVS        8
> However it appears arbitray to me. Doesn't make much sence since you can create
> /dev/md100 and it may well be the only md device you have...
> 
> Is there any reason the next 2.4.1 prepatch should not include this?
> 
> -#define MAX_MD_BOOT_DEVS       8
> +#define MAX_MD_BOOT_DEVS       MAX_MD_DEVS
> 
> (If not I assume you will be submitting this to Linus...)
> 
> -- 
> "Nobody will ever be safe until the last cop is dead."
> 		NH Rep. Tom Alciere - (My new Hero)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
