Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWAXU1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWAXU1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 15:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWAXU1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 15:27:15 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:51190 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965005AbWAXU1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 15:27:15 -0500
Message-ID: <43D68DA3.2020209@namesys.com>
Date: Tue, 24 Jan 2006 12:27:15 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [Patch]  reiser4: change warnings to not scare users needlessly
References: <43D5E82B.4060600@namesys.com> <43D5F175.7070600@namesys.com>
In-Reply-To: <43D5F175.7070600@namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hans Reiser

> 1. re-phrase "disabling write barrier" warning which confuses users and
>
>>   make it KERN_NOTICE instead of KERN_WARNING.
>> 2. remove the "[nikita-38210]: WARNING: stale dk" at
>> fs/reiser4/search.c   which does not indicate any reiser4 tree or fs
>> problems.
>>
>> Signed-off-by: Alex Zarochentsev <zam@namesys.com>
>> ---
>>
>> fs/reiser4/debug.h  |    5 ++++-
>> fs/reiser4/search.c |    2 --
>> fs/reiser4/wander.c |    3 ++-
>> 3 files changed, 6 insertions(+), 4 deletions(-)
>>
>> --- linux-2.6.x.orig/fs/reiser4/debug.h
>> +++ linux-2.6.x/fs/reiser4/debug.h
>> @@ -205,10 +205,13 @@ extern int is_in_reiser4_context(void);
>> #define wrong_return_value( label, function )                \
>>     impossible( label, "wrong return value from " function )
>>
>> -/* Issue warning message to the console */
>> +/* Issue different types of reiser4 messages to the console */
>> #define warning( label, format, ... )                    \
>>     DCALL( KERN_WARNING,                         \
>>            printk, 1, label, "WARNING: " format , ## __VA_ARGS__ )
>> +#define notice( label, format, ... )                    \
>> +    DCALL( KERN_NOTICE,                         \
>> +           printk, 1, label, "NOTICE: " format , ## __VA_ARGS__ )
>>
>> /* mark not yet implemented functionality */
>> #define not_yet( label, format, ... )                \
>> --- linux-2.6.x.orig/fs/reiser4/search.c
>> +++ linux-2.6.x/fs/reiser4/search.c
>> @@ -1359,8 +1359,6 @@ static void update_stale_dk(reiser4_tree
>>     if (unlikely(ZF_ISSET(node, JNODE_RIGHT_CONNECTED) &&
>>              right && ZF_ISSET(right, JNODE_DKSET) &&
>>              !keyeq(&rd, znode_get_ld_key(right)))) {
>> -        /* does this ever happen? */
>> -        warning("nikita-38210", "stale dk");
>>         assert("nikita-38211", ZF_ISSET(node, JNODE_DKSET));
>>         read_unlock_dk(tree);
>>         read_unlock_tree(tree);
>> --- linux-2.6.x.orig/fs/reiser4/wander.c
>> +++ linux-2.6.x/fs/reiser4/wander.c
>> @@ -230,7 +230,8 @@ static inline int reiser4_use_write_barr
>>
>> static void disable_write_barrier(struct super_block * s)
>> {
>> -    warning("zam-1055", "disabling write barrier\n");
>> +    notice("zam-1055", "%s does not support write barriers,"
>> +           " using synchronous write instead.\n", s->s_id);
>>     set_bit((int)REISER4_NO_WRITE_BARRIER,
>> &get_super_private(s)->fs_flags);
>> }
>>
>>
>>
>>  
>>
>
>
>

