Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316407AbSEOSoS>; Wed, 15 May 2002 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316469AbSEOSoR>; Wed, 15 May 2002 14:44:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2058 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316407AbSEOSoR>;
	Wed, 15 May 2002 14:44:17 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205151842.g4FIgn0158748@saturn.cs.uml.edu>
Subject: Re: [RFC] FAT extension filters
To: mark@mark.mielke.cc (Mark Mielke)
Date: Wed, 15 May 2002 14:42:49 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        msmith@operamail.com (Malcolm Smith), linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
In-Reply-To: <20020515140542.A3621@mark.mielke.cc> from "Mark Mielke" at May 15, 2002 02:05:43 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke writes:
> On Wed, May 15, 2002 at 01:49:46PM -0400, Albert D. Cahalan wrote:

>> I think the problem is in fs/fat/dir.c where
>> it does:
>>         for (i = 0; i < 8; i++) {
>>                 /* see namei.c, msdos_format_name */
>>                 if (de->name[i] == 0x05)
>>                         work[i] = 0xE5;
>>                 else
>>                         work[i] = de->name[i];
>>         }
>> That should be:
>>         for (i = 0; i < 8; i++) work[i] = 0xE5;
>>          /* see namei.c, msdos_format_name */
>>         if (*work == 0x05) *work = 0xE5;
>
> I assume that should be:
>
>>         for (i = 0; i < 8; i++) work[i] = de->name[i];
>>          /* see namei.c, msdos_format_name */
>>         if (*work == 0x05) *work = 0xE5;

Sure, and using memcpy() might be good too. I wasn't
paying much attention. Here:

        memcpy(work,de->name,8);
        /* see namei.c, msdos_format_name */
        if(*work == 0x05) *work = 0xE5;
