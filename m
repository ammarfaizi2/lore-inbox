Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUCRM3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUCRM3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:29:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60352 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262584AbUCRM3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:29:33 -0500
Date: Thu, 18 Mar 2004 12:29:32 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.4.25)
Message-ID: <20040318122932.GK31500@parcelfarce.linux.theplanet.co.uk>
References: <20040315035559.GC30948@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315035559.GC30948@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 04:55:59AM +0100, Herbert Poetzl wrote:
>  	if (count != 0) {
> -		UPDATE_ATIME(file->f_dentry->d_inode);
> +		UPDATE_ATIME(file->f_dentry->d_inode, file->f_vfsmnt);

For crying out loud...  Make that touch_file(file) and be done with that.
There's a lot of places where we do just that (touch atime of opened file)
and passing pair of vfsmount and inode (not even vfsmount and dentry) is
just plain wrong.
