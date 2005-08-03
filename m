Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVHCLQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVHCLQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVHCLQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:16:01 -0400
Received: from send.forptr.21cn.com ([202.105.45.50]:58009 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S262239AbVHCLP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:15:57 -0400
Message-ID: <42F0A7ED.5090802@21cn.com>
Date: Wed, 03 Aug 2005 19:18:05 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Question]No memory release after enlarge fib_info hash table
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux 2.6.12.3

net/ipv4/fib_semantics.c:line 679


        if (fib_info_cnt >= fib_hash_size) {
                unsigned int new_size = fib_hash_size << 1;
                struct hlist_head *new_info_hash;
                struct hlist_head *new_laddrhash;
                unsigned int bytes;

                if (!new_size)
                        new_size = 1;
                bytes = new_size * sizeof(struct hlist_head *);
                new_info_hash = fib_hash_alloc(bytes);
                new_laddrhash = fib_hash_alloc(bytes);
                if (!new_info_hash || !new_laddrhash) {
                        fib_hash_free(new_info_hash, bytes);
                        fib_hash_free(new_laddrhash, bytes);
                } else {
                        memset(new_info_hash, 0, bytes);
                        memset(new_laddrhash, 0, bytes);

                        fib_hash_move(new_info_hash, new_laddrhash, 
new_size);
                }

                if (!fib_hash_size)
                        goto failure;
        }

In fib_hash_move, there is no code call fib_hash_free to release memory 
used by old hash table.  after call fib_hash_move,  fib_info_hash and 
fib_info_laddrhash  are  the new memory addresses , old addresses  are 
lost. Is this a bug?

                                   thanks
