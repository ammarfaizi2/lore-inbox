Return-Path: <SRS0=XxtN=2G=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2375C2D0C3
	for <io-uring@archiver.kernel.org>; Mon, 16 Dec 2019 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E6521835
	for <io-uring@archiver.kernel.org>; Mon, 16 Dec 2019 19:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ys4Khj8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLPT1f (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:27:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46206 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPT1f (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 16 Dec 2019 14:27:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so4206201oii.13
        for <io-uring@vger.kernel.org>; Mon, 16 Dec 2019 11:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+G9OIzIPCPm1JV6NSLldblOL7vU1hFAd0fconVteSc=;
        b=Ys4Khj8K29YV1vXqYHp0UjjI6Gv7ahLPIwc+IlMeeZLi1fWv3Sh9JSkGHDijyOBZjO
         YZUZ+DVFHUuhj+Hc84OxOpzTQRnFynExXZDiYaKrs/YiS90XD3NPBycZU6npjD7se0eh
         hC1KJGCsZKT6kkkUZgxzUircHYgX6tyznjrS4lfJJlRSUPYS5x4JSjz45AVaB+LmQE6X
         1Bs17tlGfIWNgWm7DG5teWJoKRgezhAv7I5Oi+aK0wDzmZdA2GAknSpF1vkD7oTTg09+
         UFb1rHyaw+4Nwx+4uKIyp2sGChbx6Io2YnWAEqNIei/8qgrw2c/YJL82+rXxK1Kdykr3
         zghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+G9OIzIPCPm1JV6NSLldblOL7vU1hFAd0fconVteSc=;
        b=AZSngZP7I3RT/R0AKUBLhvVEPNSkOROdIUQiBe9v88AmNJBHIFDpJMKnqRg8Sk9gzO
         gBUBIacsrDojU8nWP2K/9MgP+wDnqmHoErt1cJHgZgFAN+3E9oHnqp0E16ClO8sIPOUD
         COm8O4cOcR+cOrqoNiNbOVVDa/GzDQnTsOW8I7bMzjw157qpbGxDW5Zv3XHkTgsVDqL0
         /97HLblXvL+vROzcJPOAandr2Uu3iMe16omAt0NrNd3YmCbLeTvyUYh/HUfWTcp6aKqm
         cBS6pMk1F4kBbNHArsJ3hkAZkVMcXxeYxYYeYUb2gRXqjlsRSTf6ElfXERkvCk97gxSg
         5fbQ==
X-Gm-Message-State: APjAAAUp5hfKQzQmD3+vALLYagKAXffBX21TzByoDauDUftkAFKFEAV3
        6Fp+1ACdPQ8e2Eh+pW18SPJl15HR1YxzoC4Cj11QszAjpe4eww==
X-Google-Smtp-Source: APXvYqyRXHFfszrlmxa4RfBXv+BHx2XxRPac+Y2KuI9sOac77h1orp76XujK/GZ738T6cirXBzNlqEzsJtjD2qgUuzU=
X-Received: by 2002:aca:bb08:: with SMTP id l8mr373285oif.47.1576524454243;
 Mon, 16 Dec 2019 11:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20191213183632.19441-1-axboe@kernel.dk> <20191213183632.19441-7-axboe@kernel.dk>
In-Reply-To: <20191213183632.19441-7-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Dec 2019 20:27:07 +0100
Message-ID: <CAG48ez26wpE_K_KGsE8jfjGp3uPc_ioYhTuLv0gSmcVPPxRA3Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] fs: move filp_close() outside of __close_fd_get_file()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Fri, Dec 13, 2019 at 7:36 PM Jens Axboe <axboe@kernel.dk> wrote:
> Just one caller of this, and just use filp_close() there manually.
> This is important to allow async close/removal of the fd.
[...]
> index 3da91a112bab..a250d291c71b 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -662,7 +662,7 @@ int __close_fd_get_file(unsigned int fd, struct file **res)
>         spin_unlock(&files->file_lock);
>         get_file(file);
>         *res = file;
> -       return filp_close(file, files);
> +       return 0;

Above this function is a comment saying "variant of __close_fd that
gets a ref on the file for later fput"; that should probably be
changed to point out that you also still need to filp_close().
