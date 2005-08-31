Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVHaKDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVHaKDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHaKDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:03:41 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:1244 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750739AbVHaKDk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:03:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JNyQ1CeXW/3waI6JuIGY7By00hFZPC3atj+6pEEcCN4sQVBSqOrKdwJ5QvJtZV//DptoENHPy0mSkNwXpRrCq2v6UVZ+lujhz0HairvZDkj7ZZruXAD26SSH+fVNiBCJ2RZ55e6UpE7IWrvvK90PA4z7JRx3BIkyHHTzkaDYOEs=
Message-ID: <84144f0205083103031a858c15@mail.gmail.com>
Date: Wed, 31 Aug 2005 13:03:39 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <43156963.8020203@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> +inline
> +static int hint_index_body(const unsigned char *name, int name_len, int check_null)
> +{
> +       int i;
> +       int val = 0;
> +       unsigned char *p = (unsigned char *) name;
> +       int id = current->pid;
> +
> +       for (i=0; i<name_len; i++) {
> +               if (check_null && !*p) break;
> +               val = ((val << 1) & 0xfe) | ((val & 0x80) ? 1 : 0);
> +               val ^= *p;
> +               p ++;
> +       }
> +       id = ((id >> 8) & 0xf) ^ (id & 0xf);
> +       val = (val << 1) | (id & 1);
> +       return val & (FAT_SCAN_NWAY-1);

Couldn't you use jhash() from <linux/jhash.h> here?

                                 Pekka
