Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282708AbRK0BQE>; Mon, 26 Nov 2001 20:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282709AbRK0BPy>; Mon, 26 Nov 2001 20:15:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14604 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282708AbRK0BPg>; Mon, 26 Nov 2001 20:15:36 -0500
Message-ID: <3C02E921.3050107@zytor.com>
Date: Mon, 26 Nov 2001 17:15:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011126165920.N730@lynx.no> <9tumf0$dvr$1@cesium.transmeta.com> <9tuo54$e8p$1@cesium.transmeta.com> <3C02E856.A24BACD5@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> "H. Peter Anvin" wrote:
> 
>>Followup to:  <9tumf0$dvr$1@cesium.transmeta.com>
>>By author:    "H. Peter Anvin" <hpa@zytor.com>
>>In newsgroup: linux.dev.kernel
>>
>>>Indeed; having explicit write barriers would be a very useful feature,
>>>but the drives MUST default to strict ordering unless reordering (with
>>>write barriers) have been enabled explicitly by the OS.
>>>
>>>
>>On the subject of write barriers... such a setup probably should have
>>a serial number field for each write barrier command, and a "WAIT FOR
>>WRITE BARRIER NUMBER #" command -- which will wait until all writes
>>preceeding the specified write barrier has been committed to stable
>>storage.  It might also be worthwhile to have the equivalent
>>nonblocking operation -- QUERY LAST WRITE BARRIER COMMITTED.
>>
>>
> 
> For ext3 at least, all that is needed is a barrier which says
> "don't reorder writes across here".  Asynchronous behaviour
> beyond that is OK - the disk is free to queue multiple transactions
> internally as long as the barriers are observed.  If the power
> goes out we'll just recover up to and including the last-written
> commit block.
> 


Waiting for write barriers to clear is key to implementing fsync()
efficiently and correctly.

	-hpa


