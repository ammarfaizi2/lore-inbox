Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVJJSyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVJJSyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVJJSyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:54:00 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:30839 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751179AbVJJSx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:53:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Q4ftMYiZboFAwo3lwjgyLYBXHRV3ZBMPsS3tztxU/g9s4Wsa/sjXIGTdAOWXiUFX1J94gqc56VJmbOLd8qlWGIGb3iwOYDvaqvtQRhG1+v7TFJL8r6kcwP+lcUFh6LgvN0LjYRoYAU75BRQN/EWpkBs4ojNgz8xKYERE/cxaCi0=
Date: Mon, 10 Oct 2005 23:05:37 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/16] GFS: headers
Message-ID: <20051010190537.GA7683@mipter.zuzino.mipt.ru>
References: <20051010170948.GB22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010170948.GB22483@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 12:09:48PM -0500, David Teigland wrote:
> --- a/fs/gfs2/gfs2.h
> +++ b/fs/gfs2/gfs2.h

> +#define MAKE_MULT8(x) (((x) + 7) & ~7)

ALIGN()

> +#define GFS2_IOCTL_IDENTIFY      _GFS2C_(1)
> +#define GFS2_IOCTL_SUPER         _GFS2C_(2)

Since patch is against -mm, please, add 2 entries to
Documentation/ioctl-mess.txt. Don't bother with "I: " and "O: ", since
they aren't finished yet.

> --- a/include/linux/gfs2_ondisk.h
> +++ b/include/linux/gfs2_ondisk.h

Please, mark on-disk structures with __le{16,32,64}. It would help
typechecking with sparse.

> +#define CPIN_08(s1, s2, member, count) {memcpy((s1->member), (s2->member), (count));}
> +#define CPOUT_08(s1, s2, member, count) {memcpy((s2->member), (s1->member), (count));}
> +#define CPIN_16(s1, s2, member) {(s1->member) = le16_to_cpu((s2->member));}
> +#define CPOUT_16(s1, s2, member) {(s2->member) = cpu_to_le16((s1->member));}
> +#define CPIN_32(s1, s2, member) {(s1->member) = le32_to_cpu((s2->member));}
> +#define CPOUT_32(s1, s2, member) {(s2->member) = cpu_to_le32((s1->member));}
> +#define CPIN_64(s1, s2, member) {(s1->member) = le64_to_cpu((s2->member));}
> +#define CPOUT_64(s1, s2, member) {(s2->member) = cpu_to_le64((s1->member));}

Confusing names and implementation. CP{IN,OUT}_08 do memcpy, the rest
doesn't. "08" doesn't make sense in CPIN_08, while "16", ... do.
CPIN_64() expect fixed-endian value or host-endian? Answer is not
obvious until you look at a header. Fingers really want to type CPU
every time. I ask you to write a simple script and drop these macros
completely.

