Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUKIQDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUKIQDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKIQA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:00:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18189 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261565AbUKIQAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:00:13 -0500
To: lsr@neapel230.server4you.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Manually inline shortname_info_to_lcase()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109014358.GE6835@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 00:11:29 +0900
In-Reply-To: <20041109014358.GE6835@neapel230.server4you.de> (lsr@neapel230.server4you.de's
 message of "Tue, 9 Nov 2004 02:43:58 +0100")
Message-ID: <873bzj5a72.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsr@neapel230.server4you.de writes:

> @@ -447,20 +431,22 @@
>  	if (is_shortname && base_info.valid && ext_info.valid) {
>  		if (vfat_find_form(dir, name_res) == 0)
>  			return -EEXIST;
>  
>  		if (opt_shortname & VFAT_SFN_CREATE_WIN95) {
>  			return (base_info.upper && ext_info.upper);
>  		} else if (opt_shortname & VFAT_SFN_CREATE_WINNT) {
>  			if ((base_info.upper || base_info.lower)
>  			    && (ext_info.upper || ext_info.lower)) {
> -				*lcase = shortname_info_to_lcase(&base_info,
> -								 &ext_info);
> +				if (!base_info.upper && base_info.lower)
> +					*lcase |= CASE_LOWER_BASE;
> +				if (!ext_info.upper && ext_info.lower)
> +					*lcase |= CASE_LOWER_EXT;

Looks good. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
