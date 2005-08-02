Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVHBBoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVHBBoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 21:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVHBBoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 21:44:17 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:9662 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261356AbVHBBoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 21:44:15 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Sander <sander@humilis.net>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org, axboe@suse.de
X-X-Sender: dlang@dlang.diginsite.com
Date: Mon, 1 Aug 2005 18:43:27 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: IO scheduling & filesystem v a few processes writing a lot
In-Reply-To: <20050801144820.GC7686@favonius>
Message-ID: <Pine.LNX.4.62.0508011838140.4098@qynat.qvtvafvgr.pbz>
References: <20050731163933.GB7280@gallifrey> <20050731191607.GA7186@favonius>
 <20050801085426.GA12516@gallifrey> <20050801144820.GC7686@favonius>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Sander wrote:

> Dr. David Alan Gilbert wrote (ao):
>> * Sander (sander@humilis.net) wrote:
>>> Dr. David Alan Gilbert wrote (ao):
>>>> I was using rsync, but the problem with rsync is that I have
>>>> a back up server then filled with lots and lots of small files
>>>> - I want larger files for spooling to tape.
>>>> (Other suggestions welcome)
>>>
>>> Can't you just tar the small files from the backupserver to tape? (or,
>>> what is the problem with that?).
>>
>> Lots of small files->slow; it is an LTO-2 tape drive that is spec'd
>> at 35MByte/s - it won't get that if I'm feeding it from something
>> seeking all over.
>
> ic. Sorry if the question is stupid, but is it bad not to reach
> 35MB/sec?

with modern tape drives, when you fall out of streaming mode you are lucky 
to get 1/10 of the rated drive performance (not to mention the extra wear 
and tear on the tape and the drive)

the common thing is to do disk->disk->tape backups. use rsync to pull your 
data from the remote machines to your server, then use tar on the server 
to make the one image you want to put on the tape (frequently onto a 
different drive), then record that image to tape.

note that tar is not nessasarily the best format to use for this in the 
face of tape errors (see backup software companies for details, several 
years ago I read an interesting document from the bru backup folks that 
went into details)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
