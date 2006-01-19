Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWASDyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWASDyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWASDyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:54:46 -0500
Received: from bigip-smtp1.dyxnet.com ([202.66.146.141]:61892 "EHLO
	bigip-smtp1.dyxnet.com") by vger.kernel.org with ESMTP
	id S1030486AbWASDyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:54:45 -0500
Message-ID: <43CF0D19.6050009@thizgroup.com>
Date: Thu, 19 Jan 2006 11:52:57 +0800
From: Zhang Le <robert@thizgroup.com>
User-Agent: Mail/News 1.5 (X11/20060113)
MIME-Version: 1.0
To: Aneesh Kumar <aneesh.kumar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Add entry.S function name to tag file
References: <cc723f590601172058n67fb2200ybfffba9bc4fc72ba@mail.gmail.com>
In-Reply-To: <cc723f590601172058n67fb2200ybfffba9bc4fc72ba@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Aneesh Kumar wrote:
> How about a patch like the one attached below. I am not sure whether i
> got the regular expression correct. But it works for me.
>
> -aneesh
>
> ----------------------------------------------------------------------
>
> diff --git a/Makefile b/Makefile
> index 252a659..6c8479e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1272,7 +1272,7 @@ define cmd_tags
>      CTAGSF=`ctags --version | grep -i exuberant >/dev/null &&     \
>                  echo "-I __initdata,__exitdata,__acquires,__releases  \
>                        -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
> -                      --extra=+f --c-kinds=+px"`;                     \
> +                      --extra=+f --c-kinds=+px
--regex-asm=/ENTRY\(([^)]*)\).*/\1/f/"`;  \
>                  $(all-sources) | xargs ctags $$CTAGSF -a
>  endef
> 
In fact, ENTRY()'s are not functions
they are just label's
some are functions
some are variables
no need to add "f" here

the following is just OK
- --regex-asm=/ENTRY\(([^)]*)\).*/\1/"

the only difference between tags file generated from these two
different option
is like this
- -alignment_check    arch/i386/kernel/entry.S 
/^ENTRY(alignment_check)$/;"    r
+alignment_check    arch/i386/kernel/entry.S 
/^ENTRY(alignment_check)$/;"    f

- --
Zhang Le, Robert
Linux Engineer/Trainer

Institute of Thiz Technology Limited
Address: Unit 1004, 10/F, Tower B,
Hunghom Commercial Centre, 37 Ma Tau Wai Road,
To Kwa Wan, Kowloon, Hong Kong
Telephone: (852) 2735 2725
Mobile:(852) 9845 4336
Fax: (852) 2111 0702
URL: http://www.thizgroup.com
Public key: gpg --keyserver pgp.mit.edu --recv-keys 1E4E2973

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzw0ZvFHICB5OKXMRAsyGAJ0TeXETc5OxTaovom9YHxzQkcbpyACeLJ58
Ztl/ug1VR4JoNM8nzIwTwyk=
=zQwU
-----END PGP SIGNATURE-----

