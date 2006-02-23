Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWBWGq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWBWGq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBWGq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:46:58 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:60904 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750838AbWBWGq5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:46:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hbUrGI1WXDEoXuF5q9f26OtULdtFWj34BtbIWDZI+YaEVcNoJICMpweNC4D9+MnJckifDuvh+Vc9fVGJSOU8BQMr28gD++JmIDlB2+jXoxTzFEOdmMR0TSK+rYmEeIVUFt4L0KN3Ytkt9v3mtvxdtNtFV72Tov4prnneiqFK2y0=
Message-ID: <305c16960602222246h27341bf9qf6e4a89c1f14505e@mail.gmail.com>
Date: Thu, 23 Feb 2006 03:46:56 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cannot open initial console
Cc: vitaly@namesys.com
In-Reply-To: <305c16960602222241m1a28a718l82cfe185772449be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com>
	 <305c16960602222241m1a28a718l82cfe185772449be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> On 2/22/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > Hi all
> >
> > When i tried kernel 2.6.15.4, i noticed i cant boot it, i get
> > "warning: cannot open initial console" then it reboots. I've searched
> > for it and found the breakage occurs from 2.6.15.1 to 2.6.15.2
> >
> > Before i start to bisect to find the culpirit, and as there were few
> > changes, anyone has a good guess about what broke it?
> >
> > Thanks all in advance.
> >
>
> Found the bad patch by reversing by hand.
>
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 42afb5b..9c38f10 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1131,7 +1131,7 @@ static void handle_attrs(struct super_bl
>                         REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
>                 }
>         } else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
> -               REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
> +               REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
>         }
>  }
>
> Reversing this fixes the problem, double checked it. What was that
> patch supposed to do anyway?
>

Adding Vitaly Fertman to this thread, as he is the one who seems to
have submitted that patch.
