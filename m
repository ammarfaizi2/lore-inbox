Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWCODF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWCODF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWCODF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:05:29 -0500
Received: from alcala.terra.com.br ([200.176.10.198]:3747 "EHLO
	alcala.terra.com.br") by vger.kernel.org with ESMTP id S932097AbWCODF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:05:28 -0500
X-Terra-Karma: -2%
X-Terra-Hash: 113c6863b7bbc15d87507ed9c90def27
Message-ID: <44178469.3090907@terra.com.br>
Date: Wed, 15 Mar 2006 00:05:13 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051004
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: Eugene Teo <eugene.teo@eugeneteo.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, jkmaline@cc.hut.fi
Subject: Re: Fix hostap_cs double kfree
References: <20060315023900.GA8179@eugeneteo.net>
In-Reply-To: <20060315023900.GA8179@eugeneteo.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Eugene,

Eugene Teo wrote:

>  failed:
>-	kfree(parse);
>-	kfree(hw_priv);
>+	if (parse)
>+		kfree(parse);
>+	if (hw_priv)
>+		kfree(hw_priv);
> 	prism2_release((u_long)link);
> 	return ret;
> }
>  
>
    I don't think those if's are needed, since the kfree code already does:

void kfree(const void *objp)
{
        if (unlikely(!objp))
                return;
...
}

    But if you really want to use it, I suggest using if (likely
(!<pointer>)) there to hint gcc of a possible optimization.

    Cheers,

Felipe Damasio
