Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVCAPGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVCAPGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVCAPGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:06:17 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:65193 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261932AbVCAPGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:06:10 -0500
Message-ID: <422484DF.30504@namesys.com>
Date: Tue, 01 Mar 2005 18:06:07 +0300
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Mathieu Segaud <Mathieu.Segaud@crans.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: 2.6.11-rc5-mm1
References: <20050301012741.1d791cd2.akpm@osdl.org>	<871xazxyke.fsf@barad-dur.crans.org> <87wtsrwjms.fsf@barad-dur.crans.org>
In-Reply-To: <87wtsrwjms.fsf@barad-dur.crans.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud wrote:

>Mathieu Segaud <Mathieu.Segaud@crans.org> disait dernièrement que :
>
>Hum, one hunk didn't make it.
>The complete patch is attached
>
>  
>
>>fs/reiser4/plugin/item/ctail.c: In function `check_ctail':
>>fs/reiser4/plugin/item/ctail.c:250: attention : l'adresse de Â« ctail_ok Â» sera toujours Ã©valuÃ©e comme Ã©tant Â« true Â»
>>fs/reiser4/plugin/item/ctail.c: In function `convert_ctail':
>>fs/reiser4/plugin/item/ctail.c:1669: attention : l'adresse de Â« coord_is_unprepped_ctail Â» sera toujours Ã©valuÃ©e comme Ã©tant Â« true Â»
>>
>>    
>>
>
>Signed-off-by: Mathieu Segaud <mathieu.segaud@crans.org>
>
>  
>
>  
>

Thanks for  catching this.
Edward.

>------------------------------------------------------------------------
>
>--- fs/reiser4/plugin/item/ctail.c	2005-03-01 14:57:52.756014040 +0100
>+++ fs/reiser4/plugin/item/ctail.c.new	2005-03-01 14:57:19.791025480 +0100
>@@ -247,7 +247,7 @@
> reiser4_internal int
> check_ctail (const coord_t * coord, const char **error)
> {
>-	if (!ctail_ok) {
>+	if (!ctail_ok(coord)) {
> 		if (error)
> 			*error = "bad cluster shift in ctail";
> 		return 1;
>@@ -1666,7 +1666,7 @@
> 		detach_convert_idata(pos->sq);
> 		break;
> 	case CRC_OVERWRITE_ITEM:
>-		if (coord_is_unprepped_ctail) {
>+		if (coord_is_unprepped_ctail(&pos->coord)) {
> 			/* convert unpprepped ctail to prepped one */
> 			int shift;
> 			shift = inode_cluster_shift(item_convert_data(pos)->inode);
>
>
>
>
>  
>

