Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSFCO0p>; Mon, 3 Jun 2002 10:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316802AbSFCO0o>; Mon, 3 Jun 2002 10:26:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38385 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316798AbSFCO0o>; Mon, 3 Jun 2002 10:26:44 -0400
Subject: Re: [PATCH] I2O support on alpha.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierrick Hascoet <pierrick.hascoet@hydromel.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206031049010.11680-200000@host.alias.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Jun 2002 16:29:06 +0100
Message-Id: <1023118146.3439.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 10:23, Pierrick Hascoet wrote:
>  		msg[0] = (FIVE_WORD_MSG_SIZE|SGL_OFFSET_0);
>  		msg[1] = I2O_CMD_BLOCK_CFLUSH<<24|HOST_TID<<12|dev->tid;
>  		msg[2] = i2ob_context|0x40000000;
> -		msg[3] = (u32)query_done;
> +		msg[3] = (unsigned long)query_done;

query_done is a 64bit value, msg[3] is 32bit. On your box it happens
that the query_done value fits into 32 bits. Really the pointer needs
replacing with something saner. I have some ideas. One would be to add

		val = i2o_query_alloc(address);
		i2o_query_done(val);
		i2o_query_free(val);

functionality that tracked the pointers in a seperate array

Similar problems in the fp->private_data casting too. That wants pushing
into an array of some sort. I'll apply the header changes and other
fixes and think about the harder ones

