Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVBUB1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVBUB1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 20:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVBUB1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 20:27:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43444 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261177AbVBUB06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 20:26:58 -0500
Message-ID: <421938D2.3030302@pobox.com>
Date: Sun, 20 Feb 2005 20:26:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
References: <20050219083431.GN4337@stusta.de>
In-Reply-To: <20050219083431.GN4337@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make a needlessly global function static
> - make three needlessly global structs static
> 
> Since after moving the now-static stucts to smc-mca.c the file smc-mca.h 
> was empty except for two #define's, I've also killed the rest of 
> smc-mca.h .
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/net/smc-mca.c |   60 +++++++++++++++++++++++++++++++++++++++--
>  drivers/net/smc-mca.h |   61 ------------------------------------------
>  2 files changed, 58 insertions(+), 63 deletions(-)
> 
> --- linux-2.6.11-rc3-mm2-full/drivers/net/smc-mca.h	2004-12-24 22:35:23.000000000 +0100
> +++ /dev/null	2004-11-25 03:16:25.000000000 +0100
> @@ -1,61 +0,0 @@
> -/*
> - * djweis weisd3458@uni.edu
> - * most of this file was taken from ps2esdi.h
> - */
> -
> -struct {
> -  unsigned int base_addr;
> -} addr_table[] = {
> -    { 0x0800 },
> -    { 0x1800 },
> -    { 0x2800 },
> -    { 0x3800 },
> -    { 0x4800 },
> -    { 0x5800 },
> -    { 0x6800 },
> -    { 0x7800 },
> -    { 0x8800 },
> -    { 0x9800 },
> -    { 0xa800 },
> -    { 0xb800 },
> -    { 0xc800 },
> -    { 0xd800 },
> -    { 0xe800 },
> -    { 0xf800 }
> -};
> -
> -#define MEM_MASK 64
> -
> -struct {
> -  unsigned char mem_index;
> -  unsigned long mem_start;
> -  unsigned char num_pages;
> -} mem_table[] = {
> -    { 16, 0x0c0000, 40 },
> -    { 18, 0x0c4000, 40 },
> -    { 20, 0x0c8000, 40 },
> -    { 22, 0x0cc000, 40 },
> -    { 24, 0x0d0000, 40 },
> -    { 26, 0x0d4000, 40 },
> -    { 28, 0x0d8000, 40 },
> -    { 30, 0x0dc000, 40 },
> -    {144, 0xfc0000, 40 },
> -    {148, 0xfc8000, 40 },
> -    {154, 0xfd0000, 40 },
> -    {156, 0xfd8000, 40 },
> -    {  0, 0x0c0000, 20 },
> -    {  1, 0x0c2000, 20 },
> -    {  2, 0x0c4000, 20 },
> -    {  3, 0x0c6000, 20 }
> -};
> -
> -#define IRQ_MASK 243
> -struct {
> -   unsigned char new_irq;
> -   unsigned char old_irq;
> -} irq_table[] = {
> -   {  3,  3 },
> -   {  4,  4 },
> -   { 10, 10 },
> -   { 14, 15 }
> -};
> --- linux-2.6.11-rc3-mm2-full/drivers/net/smc-mca.c.old	2005-02-16 18:44:29.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/smc-mca.c	2005-02-16 18:47:24.000000000 +0100
> @@ -49,7 +49,6 @@
>  #include <asm/system.h>
>  
>  #include "8390.h"
> -#include "smc-mca.h"
>  
>  #define DRV_NAME "smc-mca"
>  
> @@ -100,6 +99,63 @@
>  MODULE_PARM_DESC(ultra_io, "SMC Ultra/EtherEZ MCA I/O base address(es)");
>  MODULE_PARM_DESC(ultra_irq, "SMC Ultra/EtherEZ MCA IRQ number(s)");
>  
> +static struct {
> +  unsigned int base_addr;
> +} addr_table[] = {
> +    { 0x0800 },
> +    { 0x1800 },
> +    { 0x2800 },
> +    { 0x3800 },
> +    { 0x4800 },
> +    { 0x5800 },
> +    { 0x6800 },
> +    { 0x7800 },
> +    { 0x8800 },
> +    { 0x9800 },
> +    { 0xa800 },
> +    { 0xb800 },
> +    { 0xc800 },
> +    { 0xd800 },
> +    { 0xe800 },
> +    { 0xf800 }
> +};
> +
> +#define MEM_MASK 64
> +
> +static struct {
> +  unsigned char mem_index;
> +  unsigned long mem_start;
> +  unsigned char num_pages;
> +} mem_table[] = {
> +    { 16, 0x0c0000, 40 },
> +    { 18, 0x0c4000, 40 },
> +    { 20, 0x0c8000, 40 },
> +    { 22, 0x0cc000, 40 },
> +    { 24, 0x0d0000, 40 },
> +    { 26, 0x0d4000, 40 },
> +    { 28, 0x0d8000, 40 },
> +    { 30, 0x0dc000, 40 },
> +    {144, 0xfc0000, 40 },
> +    {148, 0xfc8000, 40 },
> +    {154, 0xfd0000, 40 },
> +    {156, 0xfd8000, 40 },
> +    {  0, 0x0c0000, 20 },
> +    {  1, 0x0c2000, 20 },
> +    {  2, 0x0c4000, 20 },
> +    {  3, 0x0c6000, 20 }
> +};
> +
> +#define IRQ_MASK 243
> +static struct {

these tables should be const-ified


