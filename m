Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVASSXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVASSXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVASSX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:23:29 -0500
Received: from [207.168.29.180] ([207.168.29.180]:63653 "EHLO
	jp.mwwireless.net") by vger.kernel.org with ESMTP id S261832AbVASSWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:22:51 -0500
Message-ID: <41EEA575.9040007@mvista.com>
Date: Wed, 19 Jan 2005 10:22:45 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in shared_policy_replace() ?
References: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain> <41EE9991.6090606@mvista.com> <20050119174506.GH7445@wotan.suse.de>
In-Reply-To: <20050119174506.GH7445@wotan.suse.de>
Content-Type: multipart/mixed;
 boundary="------------090409010005090609090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090409010005090609090705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Andi Kleen wrote:

>>got it, except that there is no "new2 = NULL;" in 2.6.10-mm2!
>>
>>Looks like it was misplaced, because I do see it now in 2.6.10.
>>    
>>
>
>I double checked 2.6.10 and the code also looks correct me,
>working as described by Hugh.
>
>Optimistic locking can be ugly :)
>  
>

yeah, 2.6.10 makes sense to me too. But I'm working in -mm2, and
the new2 = NULL line is missing, hence my initial confusion. Trivial
patch to -mm2 attached. Just want to make sure it has been, or will be,
put back in.

Steve

--------------090409010005090609090705
Content-Type: text/plain;
 name="mempolicy-mm2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempolicy-mm2.diff"

--- mm/mempolicy.c.orig	2005-01-19 09:52:47.153910873 -0800
+++ mm/mempolicy.c	2005-01-19 09:53:21.548999628 -0800
@@ -1041,6 +1041,7 @@
 				}
 				n->end = start;
 				sp_insert(sp, new2);
+				new2 = NULL;
 				break;
 			} else
 				n->end = start;

--------------090409010005090609090705--
