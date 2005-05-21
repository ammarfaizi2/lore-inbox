Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVEUGWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVEUGWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEUGWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:22:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:50825 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261679AbVEUGVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:21:22 -0400
Date: Fri, 20 May 2005 23:28:17 -0700
From: Greg KH <greg@kroah.com>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       kylene@us.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com
Subject: Re: [PATCH 3 of 4] ima: Linux Security Module implementation
Message-ID: <20050521062817.GD24597@kroah.com>
References: <1116596614.8156.11.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116596614.8156.11.camel@secureip.watson.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 09:43:34AM -0400, Reiner Sailer wrote:
> +/* security structure appended to inodes */
> +#define IMA_MAGIC 0x9999
> +struct ima_inode {
> +	unsigned short magic;
> +	atomic_t measure_count;	/* # processes currently using this file in measure-mode */
> +	ima_entry_flags dirty;
> +	char *file_name;	/* points to measure entry->fileName */
> +};
> +
> +/* security structure appended to measured files*/
> +struct ima_file {
> +	unsigned short magic;	/* identify our struct format */
> +	char is_measuring;	/* identify fds that are "measuring" */
> +};

magic values for structures protect you from nothing.  Do not use them.


> +static u32 decode_u32(u8 * buf)
> +{
> +	u32 val = buf[0];
> +	val = (val << 8) | (u8) buf[1];
> +	val = (val << 8) | (u8) buf[2];
> +	val = (val << 8) | (u8) buf[3];
> +	return val;
> +}
> +
> +static void encode_u32(u8 * buf, u32 val)
> +{
> +	buf[0] = (u8) val >> 24;
> +	buf[1] = (u8) val >> 16;
> +	buf[2] = (u8) val >> 8;
> +	buf[3] = (u8) val >> 0;
> +}

Hm, what's wrong with the standard kernel functions to do this kind of
thing?


> diff -uprN linux-2.6.12-rc4/security/ima/INSTALL linux-2.6.12-rc4-ima/security/ima/INSTALL
> --- linux-2.6.12-rc4/security/ima/INSTALL	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.12-rc4-ima/security/ima/INSTALL	2005-05-19 17:59:20.000000000 -0400

Kernel directories do not get a INSTALL file.  Stuff like that goes into
the Documentation/ directory.

greg k-h
