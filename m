Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbUH2Sdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbUH2Sdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUH2Sdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:33:46 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18131 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268238AbUH2Sdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:33:41 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <4132205A.9080505@namesys.com>
Date: Sun, 29 Aug 2004 11:28:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: flx@msu.ru
CC: Paul Jackson <pj@sgi.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias>
In-Reply-To: <20040829150231.GE9471@alias>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Lyamin wrote:

>Fri, Aug 27, 2004 at 11:08:57PM -0700, Paul Jackson wrote:
>  
>
>>
>>One possible way to do this, of no doubt many:
>>
>> * Stealing a corner of the existing filename space for
>>   some magic names with the new semantics.
>>
>> * A new option on open(2), hence opendir(3), that lights up
>>   these magic names.
>>
>> * Doing any of the classic pathname calls with such a
>>   new magic name exposes the new semantics - such calls
>>   as:
>>	access execve mkdir mknod mount readlink
>>	rename rmdir stat truncate unlink
>>
>>This means essentially constructing a map between old and new,
>>such that changes made in either view are sane and visible
>>from the other view.
>>    
>>
>
>It would be intresting to hear comments from Hans Reiser on proposals stated  above...
>
>
>  
>
just use a view, and skip the options on the system calls.  if you cd to 
/nometas/your_home_directory_path you don't see the metafiles.  Why is a 
view better than a syscall flag?  Because it lets the user choose what 
he wants without recompiling to do it.  This kind of a view requires no 
coding because you can just mount the root filesystem two ways, one with 
the -nopseudos mount option, and one without it.
