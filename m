Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263575AbUJ2VUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbUJ2VUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUJ2VS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:18:28 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14070 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263575AbUJ2VPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:15:36 -0400
Message-ID: <4182B2FF.9040902@namesys.com>
Date: Fri, 29 Oct 2004 14:15:43 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org> <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int>
In-Reply-To: <20041028114413.GL1343@schnapps.adilger.int>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Oct 28, 2004  11:34 +0200, Matthias Andree wrote:
>  
>
>>On Mon, 25 Oct 2004, Theodore Ts'o wrote:
>>    
>>
>>>And that's because there's no good way to do this without trashing the
>>>performance of the system, especially when most applications don't
>>>care.  (Do you really want your entire system running significantly
>>>slower, penalizing all other applications on your system, just because
>>>of one stupid/badly-written application?)
>>>      
>>>
>>Please - is it really necessary that application writers are offended in
>>this way? Timo is investing enormous time and effort in writing a *good*
>>application, and he's effectively seeking a way to *robustly* deal with
>>Maildir format mail storage. Please leave it at "readdir/getdents don't
>>work the way you expect and cannot for this and that reason."
>>
>>Timo tries to implement a *robust* Maildir reader and has just bumped
>>into the flaws of DJB's "no-locking" store.
>>
>>Yes, it's a mail server again that poses file system questions on this
>>list; only it's IMAP this time rather than SMTP and directory
>>synchronous I/O...
>>    
>>
Matthias is right.  readdir is badly architected, and no one has fixed 
it for ~30 years.

It should be possible to perform an atomic readdir if that is what you 
want to do and if you have space in your process to stuff the result.

Hans
