Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278307AbRJSEjQ>; Fri, 19 Oct 2001 00:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278306AbRJSEjG>; Fri, 19 Oct 2001 00:39:06 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59553 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278305AbRJSEi5>; Fri, 19 Oct 2001 00:38:57 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Toivo Pedaste <toivo@eleusis.ucs.uwa.edu.au>,
        Rik van Riel <riel@conectiva.com.br>
Date: Fri, 19 Oct 2001 14:39:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15311.44663.227652.817688@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Toivo Pedaste on Friday October 19
In-Reply-To: <0110191100090D.09386@eleusis.ucs.uwa.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 19, toivo@eleusis.ucs.uwa.edu.au wrote:
> 
> 
> >However I actually want to charge usage to users.
> >There is a natural mapping from users to directory trees via the
> >concept of the home-directory.  It is home directories that I want to
> >impose quotas on.  So it seems natural to charge space usage to a
> >users.
> 
> 
> The use I can see for tree quotas whould be quite divorced from
> accounts or users. Currently if you want limit the amount of
> space the say /tmp, /home or /var/mail uses you need to put
> it on a separate partition, but if you could put a quota 
> on a tree you'd have a much more flexible systema adminstration
> tool to control the disk space used by each particular function.

This relates to Rik's idea of having a treequota on "/home/students"
which would apply to all students, not any one user.

One issue here is: how do you tell the quota-system what constitutes a
   tree, for quota purposes.

NetworkAppliances have had treequotas on their filer for quite some
time, and I believe that you have to create quota trees explicitly
with "qtree create"

I would rather not have to add such a new command if I can avoid it.

For the above senarios,  I would simply create an accout called "tmp"
or "home" or "mail" (you might have that one already) or "student",
assign a quota to that account, and chown the directory appropriately.
Afterall, there is no real reason why /tmp should be owned by "root".
Any "system" account should be fine.

Can anyone else see a good way to flag an inode as "root-of-a-qtree"
that does not require a new command and does not relate to uids?

NeilBrown


> 
> I quite like the idea of the quota being related to an inode.
> -- 
>  Toivo Pedaste                        Email:  toivo@ucs.uwa.edu.au
>  University Communications Services,  Phone:  +61 8 9 380 2605
>  University of Western Australia      Fax:    +61 8 9 380 1109
> "The time has come", the Walrus said, "to talk of many things"...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
