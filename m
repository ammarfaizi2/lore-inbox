Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUJ3VoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUJ3VoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUJ3Vmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:42:49 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10765 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261338AbUJ3Vlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:41:42 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] efs: make a struct static
Date: Sun, 31 Oct 2004 00:41:25 +0300
User-Agent: KMail/1.5.4
References: <20041030175636.GP4374@stusta.de>
In-Reply-To: <20041030175636.GP4374@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410310041.25152.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 20:56, Adrian Bunk wrote:
> The patch below makes a struct in the efs code static.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc1-mm2-full/include/linux/efs_vh.h.old	2004-10-30 14:03:58.000000000 +0200
> +++ linux-2.6.10-rc1-mm2-full/include/linux/efs_vh.h	2004-10-30 14:04:13.000000000 +0200
> @@ -44,7 +44,7 @@
>  #define SGI_EFS		0x07
>  #define IS_EFS(x)	(((x) == SGI_EFS) || ((x) == SGI_SYSV))
>  
> -struct pt_types {
> +static struct pt_types {
>  	int	pt_type;
>  	char	*pt_name;
>  } sgi_pt_types[] = {

You made a variable in .h file static. This is a no-no.

Only fs/efs/super.c includes linux/efs_vh.h now, but if
it will be ever included into another files, you
will get silent data duplication.

Unless I miss something, you really wanted to do:

.h file:

struct pt_types {
	int     pt_type;
	char    *pt_name;
};
extern struct pt_types sgi_pt_types[];

.c file:

struct pt_types sgi_pt_types[] = {
	{0x00,          "SGI vh"},
....
	{0,             NULL}
};

--
vda

