Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283654AbRLEBN1>; Tue, 4 Dec 2001 20:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283657AbRLEBNR>; Tue, 4 Dec 2001 20:13:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283654AbRLEBM6>; Tue, 4 Dec 2001 20:12:58 -0500
Message-ID: <3C0D7488.6060300@zytor.com>
Date: Tue, 04 Dec 2001 17:12:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jeremy Puhlman <jpuhlman@mvista.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de> <3C0D6CB6.7000905@zytor.com> <20011204164941.A29968@one-eyed-alien.net> <20011204170235.M25671@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Puhlman wrote:

> On Tue, Dec 04, 2001 at 04:49:41PM -0800, Matthew Dharm wrote:
> 
>>There is another argument for supporting both endiannesses....
>>
>>Consider an embedded system which can be run in either endianness.  Sounds
>>silly?  MIPS processors can run big or little endian, and many people
>>routinely switch between them.
>>
> Yes but typically this also includes a step of reflashing firmware or
> swaping of firmware...So it would not be unrealistic to swap out the
> filesystem as well...
> 
> Since in a deployment situation you will always be sticking with one endianness 
> it makes sense that you would want the most speed for your buck...Since flash 
> filesystems are slow to begin with also adding in the decompression
> hit you get from cramfs...it would seem to me that adding in le<->be
> would just add to its speed reduction....That would seem to be a good
> place to trim the fat so to speak...
> 


Actually, you've got it completely backwards.  Because the compression
system used (deflate) is endian-independent, the only thing in cramfs that
is endian-sensitive is the metadata.  Byteswapping the metadata is
probably not a measurable performance effect.

	-hpa

