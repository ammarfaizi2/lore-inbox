Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264808AbSKRVGb>; Mon, 18 Nov 2002 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSKRVGb>; Mon, 18 Nov 2002 16:06:31 -0500
Received: from ulima.unil.ch ([130.223.144.143]:49561 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264808AbSKRVG3>;
	Mon, 18 Nov 2002 16:06:29 -0500
Date: Mon, 18 Nov 2002 22:13:30 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 and SCSI ?
Message-ID: <20021118211330.GA8870@ulima.unil.ch>
References: <20021118203605.GC8357@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021118203605.GC8357@ulima.unil.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

same result with vanilla with just this devfs patch:

802,804c802,804
<     struct timespec atime;
<     struct timespec mtime;
<     struct timespec ctime;
---
>     time_t atime;
>     time_t mtime;
>     time_t ctime;
2512,2514c2512,2514
<     de->inode.atime = inode->i_atime;
<     de->inode.mtime = inode->i_mtime;
<     de->inode.ctime = inode->i_ctime;
---
>     de->inode.atime = inode->i_atime.tv_sec;
>     de->inode.mtime = inode->i_mtime.tv_sec;
>     de->inode.ctime = inode->i_ctime.tv_sec;
2613,2615c2613,2618
<     inode->i_atime = de->inode.atime;
<     inode->i_mtime = de->inode.mtime;
<     inode->i_ctime = de->inode.ctime;
---
>     inode->i_atime.tv_sec = de->inode.atime;
>     inode->i_mtime.tv_sec = de->inode.mtime;
>     inode->i_ctime.tv_sec = de->inode.ctime;
>     inode->i_atime.tv_nsec = 0;
>     inode->i_mtime.tv_nsec = 0;
>     inode->i_ctime.tv_nsec = 0;

Isn't that the right fix for fs/devfs/base.c ?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
