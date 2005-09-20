Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVITD5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVITD5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVITD5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:57:22 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:46687 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964869AbVITD5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:57:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J5lXt8BkPVmPg/Rfn8/83dn2FAgUnbvjV1cQ7esQzHE/BBVF1oijnWEosFuQpD64Elkj3htx4onc1EnYmKEYM96TiJrPTQckjT9FRzdBpvKxodXy/JTH/r4Ga0nTgJ6QrGoH+254p4qSDiVwquqeuLqQdWzKKzO2hqVhfmdnp7g=
Message-ID: <feed8cdd0509192057e1aa9e3@mail.gmail.com>
Date: Mon, 19 Sep 2005 20:57:20 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: stephen.pollei@gmail.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: Nikita Danilov <nikita@clusterfs.com>, Denis Vlasenko <vda@ilport.com.ua>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200509192316.j8JNFxY8030819@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <nikita@clusterfs.com>
	 <17197.15183.235861.655720@gargle.gargle.HOWL>
	 <200509192316.j8JNFxY8030819@inti.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Nikita Danilov <nikita@clusterfs.com> wrote:
> > It's other way around: declaration is guarded by the preprocessor
> > conditional so that nobody accidentally use znode_is_loaded() outside of
> > the debugging mode.
> 
> Since when has a missing declaration prevented anyone calling a function in
> C?!
Never AFAIK... K&R, ANSI,ISO C89,  c99, whatever version that I know of...
You'd need -Werror and -Wmissing-prototype to make that worth it.
Otherwise the standard says they namesys requested "please make a good
quess as to what the args are...".
K&R didn't even have the kind of prototypes we know and love today...
So they shouldn't do this half-ass #if/#endif stuff.. either rip it
out, or be a man and make the compile fail when someone calls
znode_is_loaded , if thats what you really want. It's really over
silly anyway, as it will fail at link time if they had matching
preprocessor stuff around the function definition.
#if defined(DEBUG_THIS) || defined(DEBUG_THAT)
int znode_is_loaded(const znode * node) {return !!node->had_too_much_to_drink;}
#endif

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
