Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289411AbSAJL6n>; Thu, 10 Jan 2002 06:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289412AbSAJL6d>; Thu, 10 Jan 2002 06:58:33 -0500
Received: from mustard.heime.net ([194.234.65.222]:42385 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289411AbSAJL6Q>; Thu, 10 Jan 2002 06:58:16 -0500
Date: Thu, 10 Jan 2002 12:58:14 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Fixing the vm or merging rmap into the official tree? (fwd)
Message-ID: <Pine.LNX.4.30.0201101257540.21860-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you _could_ try this:
>
> --- linux-2.4.18-pre2/mm/filemap.c	Mon Jan  7 16:48:03 2002
> +++ linux-akpm/mm/filemap.c	Thu Jan 10 02:57:01 2002
> @@ -737,6 +737,7 @@ static int page_cache_read(struct file *
>
>  	if (!add_to_page_cache_unique(page, mapping, offset, hash)) {
>  		int error = mapping->a_ops->readpage(file, page);
> +		activate_page(page);
>  		page_cache_release(page);
>  		return error;
>  	}

No effect.

# vmstat 2
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 99  0      0 220900  19100 592828   0   0 32628     0  642   444   0   8  92
 0 99  0      0 154204  19176 657272   0   0 32256    12  653   448   0   9  90
 0 99  0      0  86540  19260 722628   0   0 32720     0  643   380   0   6  93
 0 99  0      0  14396  19352 784392   0   0 30924    22  607   381   0  10  90
 0 99  1      0   3260  17320 793044   0   0 32238     0  653   439   0  13  87
 0 99  1      0   3256  14740 791520   0   0 30336     0  665   374   0  12  88
 0 99  1      0   3276  13332 780592   0   0 32934     0  658   439   0  14  85
 0 99  1    868   3204  10316 779348   0 320 34094   326  681   361   0  17  83
 0 99  0    868   3224  10376 779192   0   0 29722    18  619   443   0   9  91
 0 99  1    912   3304  10424 775104   0   0 29356     0  633   503   0  12  88
 0 99  1    912   3272  10444 775340   0 128 21394   140  546   428   0   7  92
 0 99  0    912   3284  10484 774728   0   0 23020    66  567   478   0   6  93
 0 99  0    912   3320  10492 774004   0   0 19178     0  517   388   0   6  94
 0 99  0    912   3232  10504 773160   0   0 17396     0  478   414   0   6  94
 0 99  1    912   3304  10520 771972   0   0 14148     0  464   436   0   6  94
 0 99  0    912   3320  10536 770768   0   0 13884     0  476   418   0   6  94
 0 99  1    912   4388  10548 768324   0   0 13894     0  493   518   0   5  95
 0 99  0    912   3224   9456 765536   0   0 11834     0  470   422   0   8  92
 0 99  0    912   3256   9252 763828   0   0   960    22  350   502   0   2  98
 0 99  0    912   3308   9000 762228   0   0  2784     0  362   481   0   3  97
 0 99  0    912   3260   8104 761396   0   0  2398     0  340   476   0   3  97
 0 99  0    912   3312   7020 756728   0   0  3656    28  373   444   0   4  95
 0 99  0    912   3220   6924 755032   0   0   962     0  343   498   0   3  97
 0 99  0    912   3224   6824 753224   0   0   964     0  343   503   0   2  98

> Or you could help me reproduce it.

I don't understand anything... The only way I can avoid it is with the
rmap patch.

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.



