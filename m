Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318862AbSG0Xa0>; Sat, 27 Jul 2002 19:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318863AbSG0Xa0>; Sat, 27 Jul 2002 19:30:26 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:41621 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318862AbSG0XaZ>; Sat, 27 Jul 2002 19:30:25 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Austin Gonyou" <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Ville Herva" <vherva@niksula.hut.fi>, "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sat, 27 Jul 2002 16:34:34 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECMEPKCPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1027816089.21516.9.camel@irongate.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2002-07-28 at 00:01, Buddy Lumpkin wrote:
>> Are you implying that it should be looking for pages to swap out this
whole
>> time to free up more space for filesystem and executable pages purely
based
>> on lru? Have you done testing to prove that this is a better approach
than
>> setting a threshold of when to wake up the lru mechanism?

>Not all the time - when there is pressure to find more pages.

ok, then it turns out that we agree, Solaris does "the right thing" in this
respect.


>> Solaris keeps dirty pages after they have been flushed to their backing
>> store, it's just when the system has to choose something to flush that it
>> preferences filesystem over anonymous and executable, what's wrong with
>> that?

>Many of its pages are both file system and executable. Solaris shares
>read-only pages between the caches and the mappings into process spaces.
>I can understand favouring flushing mapped files because swap is
>generally slower than restoring a file backed mapping

right, solaris share everything!

it maps text, data, etc... MAP_PRIVATE (COW) and uses the segmap to unify
access between read, write and mmaped MAP_SHARED pages so that
only a single page exists for any single filesystem page. You can see proof
of this by writing a little C program and then while it's running modify it
(say it prints for instance changes from "this is a test" to "this xx a
xxxx" ) and overwrite the new file with mmap MAP_SHARED type access or with
write(), the programs output will change on the fly while it's running.

When I differentiate between filesystem pages and executable, I should have
been specific in saying that executable pages almost always have a named
file as thier backing store, but for this discussion executable means that
the page has the execute bit set.

For priority paging they actually warn that standard files that are mmapped
will be incorrectly treated like executables if they have the execute bits
set. This probably happens quite often so it's not perfect.

--Buddy




