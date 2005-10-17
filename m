Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVJQOKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVJQOKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 10:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVJQOKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 10:10:11 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:20284 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751343AbVJQOKJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 10:10:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f35GznRerlTy9r288ra1Ab8N8/pZAfXcQPX+yJapu7TLbuvy/Y+uPDnej0Tu95YdC0gZcrv0UB2wEx+E4q3I2CgiBlOW780ji+tXsKhzFnd5aMU5N8yBr7UTrAP8G3BoME7CayZdjZikY7/2PScNsmeHuk5XqP1/f7ucVnbHe8I=
Message-ID: <9a8748490510170710s3971e0c6u2a95fa2cb6ad2c5a@mail.gmail.com>
Date: Mon, 17 Oct 2005 16:10:03 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Glauber de Oliveira Costa <glauber@br.ibm.com>
Subject: Re: [PATCH] Test for sb_getblk return value
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20051017132306.GA30328@br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017132306.GA30328@br.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Glauber de Oliveira Costa <glauber@br.ibm.com> wrote:
> Hi all,
>
> As we discussed earlier, I'm sending a patch that adds test for the
> return value of sb_getblk. This time I focused on the code of the ext2/3
> filesystems. I'm assuming that getblk fails happens due to I/O errors
> and thus returning returning an EIO back wherever it's needed.
>

> -		bh = sb_getblk(inode->i_sb, parent);
> +		if (!(bh = sb_getblk(inode->i_sb, parent))){
> +			err = -EIO;
> +			break;
> +		}

Would be more readable as

		bh = sb_getblk(inode->i_sb, parent);
		if (!bh) {
			err = -EIO;
			break;
		}


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
