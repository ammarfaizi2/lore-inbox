Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUF3OV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUF3OV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUF3OV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:21:26 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:44477 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266679AbUF3OVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:21:21 -0400
Message-ID: <40E2CCB2.BDDC1F07@bull.net>
Date: Wed, 30 Jun 2004 16:22:42 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr-FR,fr
MIME-Version: 1.0
To: Michael Kerrisk <mtk-lkml@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: A question about extended attributes of filesystem objects (setfattr 
 command)
References: <40E2B795.35EA5824@bull.net> <17330.1088602319@www51.gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:
> 
> Gidday,
> 
> > I have a question regarding
> >  Attributes of symlinks vs. the files pointed to
> >
> > If I try to attach name:value pair to object symlink file
> > then I'll get: "Operation not permitted"
> 
> What file system are you using?  If ext2, ext3 (or patched kernel
> supporting Reiserfs EAs), did you mount with "-o user_xattr?
> (The above error suggests you haven't used this option.)
> 
> > reading the man pages of setfattr (or attr) I thought that it operates
> > on the attributes of  the  symbolic link itself.
> 
> No, these commands follow symbolic links.
> 
> > show:
> > -----
> > touch f
> > ln -s f l
> > setfattr -n user.filename -v ascii1 f l
> > setfattr -h -n user.filename  -v ascii2 f
> > getfattr -d f l
> > setfattr -h -n user.filename  -v ascii3 l
> > setfattr -h --no-dereference -n user.filename  -v ascii4 l
> > getfattr -d f l
> >
> > so, my question is : what is expected ?
>

thanks Michael, 
below is what I was trying to find out !!
> attr(5) specifically notes that USER EAs are disallowed on
> symbolic links, but this is rather an issu that affects the
> use of lsetxattr(2).
> 
> Cheers,
> 
> Michael
> 
> --
> "Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
> Jetzt aktivieren unter http://www.gmx.net/info
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14
