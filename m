Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936985AbWLDPgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936985AbWLDPgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936998AbWLDPgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:36:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:47223 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936985AbWLDPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:36:32 -0500
Message-ID: <45744079.40600@us.ibm.com>
Date: Mon, 04 Dec 2006 09:36:25 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
References: <45708A0B.6000106@us.ibm.com> <200612022100.20609.arnd@arndb.de>
In-Reply-To: <200612022100.20609.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Friday 01 December 2006 21:01, Maynard Johnson wrote:
> 
>>+static void notify_spus_active(void)
>>+{
>>+       int node;
>>+       for (node = 0; node < MAX_NUMNODES; node++) {
>>+               struct spu *spu;
>>+               mutex_lock(&spu_prio->active_mutex[node]);
>>+               list_for_each_entry(spu, &spu_prio->active_list[node], list) {
>>+                                struct spu_context *ctx = spu->ctx;
>>+                                blocking_notifier_call_chain(&spu_switch_notifier,
>>+                                                ctx ? ctx->object_id : 0, spu);
>>+               }
>>+               mutex_unlock(&spu_prio->active_mutex[node]);
>>+        }
> 
> 
> I wonder if this is enough for oprofile. Don't you need to access user
> space data of the task running on the SPU? I always assumed you want
No, I don't need anything from the user app besides access to the 
executable binary, which I get with copy_from_user, specifying the 
'objectid' as from address.
> to do it via get_user or copy_from_user, which obviously doesn't work
> here, when you're running in the oprofile task. Are you using something
> like access_process_vm now?
> 
> 	Arnd <><


