Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264658AbSJ3Kim>; Wed, 30 Oct 2002 05:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264663AbSJ3Kim>; Wed, 30 Oct 2002 05:38:42 -0500
Received: from k100-23.bas1.dbn.dublin.eircom.net ([159.134.100.23]:39693 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S264658AbSJ3Kik>;
	Wed, 30 Oct 2002 05:38:40 -0500
Message-ID: <3DBFB7AE.6030306@corvil.com>
Date: Wed, 30 Oct 2002 10:42:54 +0000
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Khalid Aziz <khalid_aziz@hp.com>
CC: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Retrieve configuration information from kernel
References: <Pine.LNX.4.10.10210291204590.28595-100000@clements.sc.steeleye.com> <3DBED111.96A3A1E8@hp.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz wrote:
> Paul Clements wrote:
> 
>>Have you considered compressing the config info in order to reduce
>>the space wastage in the loaded kernel image? Could easily be 10's of KB
>>(not that that's a lot these days). The info would then be retrieved via
>>"gunzip -c", et al. instead of a simple "cat".
> 
> I wanted to start with a simple implementation first. There are a couple
> of things that can be done in future to further improve meory usage: (1)
> Drop "CONFIG_" and "# CONFIG_" from each line and add it back when
> printing from /proc/ikconfig and extract-ikconfig script, (2) Compress
> the resulting configuration. Something to do in near future :)

$ wc -c /usr/src/linux-2.4/.config
   38092 /usr/src/linux-2.4/.config
$ gzip -c /usr/src/linux-2.4/.config | wc -c
   10305
$ sed '/^ *$/d;/^#/d;s/^CONFIG_//'  /usr/src/linux-2.4/.config | wc -c
   17267
$ sed '/^ *$/d;/^#/d;s/^CONFIG_//'  /usr/src/linux-2.4/.config | gzip | wc -c
    6155

Also it seems like it would be more useful to have the config in the
kernel image rather than (just) proc?

Pádraig.

