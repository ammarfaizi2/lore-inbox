Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWHECCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWHECCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 22:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWHECCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 22:02:19 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30368 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1422711AbWHECCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 22:02:18 -0400
Message-ID: <44D3EE11.30705@namesys.com>
Date: Fri, 04 Aug 2006 19:02:09 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
CC: Edward Shishkin <edward@namesys.com>,
       Matthias Andree <matthias.andree@gmx.de>, ric@emc.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>	 <1154446189.15540.43.camel@localhost.localdomain>	 <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com>	 <20060803140344.GC7431@merlin.emma.line.org>	 <44D219F9.9080404@namesys.com> <44D231DF.1080804@namesys.com>	 <44D37E1B.1040109@namesys.com> <69304d110608041157p125e5c8oef58b02f6c81fa29@mail.gmail.com>
In-Reply-To: <69304d110608041157p125e5c8oef58b02f6c81fa29@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:

> On 8/4/06, Edward Shishkin <edward@namesys.com> wrote:
>
>> Hans Reiser wrote:
>> > Edward Shishkin wrote:
>> >
>> >
>> >>Matthias Andree wrote:
>> >>
>> >>
>> >>>On Tue, 01 Aug 2006, Hans Reiser wrote:
>> >>>
>> >>>
>> >>>
>> >>>>You will want to try our compression plugin, it has an ecc for every
>> >>>>64k....
>> >>>
>> >>>
>> >>>
>> >>>What kind of forward error correction would that be,
>> >>
>> >>
>> >>
>> >>Actually we use checksums, not ECC. If checksum is wrong, then run
>> >>fsck - it will remove the whole disk cluster, that represent 64K of
>> >>data.
>> >
>> >
>> > How about we switch to ecc, which would help with bit rot not
>> sector loss?
>>
>> Interesting aspect.
>>
>> Yes, we can implement ECC as a special crypto transform that inflates
>> data. As I mentioned earlier, it is possible via translation of key
>> offsets with scale factor > 1.
>>
>> Of course, it is better then nothing, but anyway meta-data remains
>> ecc-unprotected, and, hence, robustness is not increased..
>>
>> Edward.
>>
>> >
>> >>
>> >> and how much and
>> >>
>> >>
>> >>>what failure patterns can it correct? URL suffices.
>> >>>
>> >>
>> >>Checksum is checked before unsafe decompression (when trying to
>> >>decompress incorrect data can lead to fatal things). It can be
>> >>broken because of many reasons. The main one is tree corruption
>> >>(for example, when disk cluster became incomplete - ECC can not
>> >>help here). Perhaps such checksumming is also useful for other
>> >>things, I didnt classify the patterns..
>> >>
>> >>Edward.
>> >>
>> >>
>
>
> Would the storage + plugin subsystem support storing >1 copies of the
> metadata tree?
>
>
I suppose....

What would be nice would be to have a plugin that when a node fails its
checksum/ecc it knows to get it from another mirror, and which generally
handles faults with a graceful understanding of its ability to get
copies from a mirror (or RAID parity calculation).

I would happily accept such a patch (subject to usual reservation of
right to complain about implementation details).
