Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267269AbSKVBVB>; Thu, 21 Nov 2002 20:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSKVBVB>; Thu, 21 Nov 2002 20:21:01 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1932 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267269AbSKVBU6>; Thu, 21 Nov 2002 20:20:58 -0500
Subject: Re: Linux 2.4.20-rc2 screwy ac97_codec.c:codec_id()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul <set@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021122011413.GA1463@squish.home.loc>
References: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva> 
	<20021122011413.GA1463@squish.home.loc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 01:57:06 +0000
Message-Id: <1037930226.10314.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 01:14, Paul wrote:
> 	Im pretty sure this is broken, but I dont know exactly
> what it is trying to do.
> 	The first snprintf is overwritten regardless-- missing
> else block? And its format string should probably be "%4X:%4X",
> because whats there wont fit in the buffer.
> 	Then the first 3 chars in the string are filled in
> with raw numbers (For my card, non-ascii) and then a single
> decimal digit?? (This string is printed out during boot time--
> which is how I noticed it because of the 'garbage' chars.)
> 	I dont know what a PnP string is supposed to look like...

There is an else missing you are correct


> +       if(id1&0x8080)
> +               snprintf(buf, 10, "%0x4X:%0x4X", id1, id2);

else 
{

> +       buf[0] = (id1 >> 8);
> +       buf[1] = (id1 & 0xFF);
> +       buf[2] = (id2 >> 8);
> +       snprintf(buf+3, 7, "%d", id2&0xFF);

}

> +       return buf;
> +}
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

