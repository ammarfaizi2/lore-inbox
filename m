Return-Path: <linux-kernel-owner+w=401wt.eu-S932727AbWLZShg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWLZShg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 13:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWLZShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 13:37:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:37620 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbWLZShf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 13:37:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=J/gkqdEGj0+UorBUNDoSTPcx+Ap/Kipi8EnMfA3qN8IzDG2KfgJ66s86l5OoF6zGs7MlxzM9NWsixjH6MLriX+RUJV5iQrLDAatTJAJ3J0ALCUEV7GR2A/JhicQaWTDtktrAgpBn3pKXK/wQ3LMbJD7nSYEMWILZ+1Ym/FgLlWw=
Subject: Re: [patch] net/xfrm: fix crash in ipsec audit logging
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       dwmw2@infradead.org, Joy Latten <latten@austin.ibm.com>
In-Reply-To: <20061226175619.GA27982@elte.hu>
References: <20061226175619.GA27982@elte.hu>
Content-Type: text/plain
Date: Tue, 26 Dec 2006 13:37:32 -0500
Message-Id: <1167158252.3746.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-26-12 at 18:56 +0100, Ingo Molnar wrote:


> +	xfrm_audit_log(NETLINK_CB(skb).loginuid, NETLINK_CB(skb).sid,
> +		       AUDIT_MAC_IPSEC_DELSPD, delete, xp, NULL);
> +
>  	if (!delete) {
>  		struct sk_buff *resp_skb;


You could move the call into the else from above if (!delete) maybe?
Otherwise you have to add back the "if (delete)" check since that
function could be used to either retrieve (which is not subject to an
audit) or delete an xp.

cheers,
jamal
 

