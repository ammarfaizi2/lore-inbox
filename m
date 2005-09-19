Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVISTgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVISTgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVISTgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:36:18 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:35077 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932553AbVISTgQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:36:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YXmMys1MMJh7rUctef7qNZABkY4bA7LYPA7J6yJD4Naqvx1F9objl58m9nyrbGKsaSz8J7Z5qFzHRvLg74YLIqdk0HebiRfZyrsT3X9tNZKO6lU/KwMlpSGZOPgyGARAkJd2mD0eFFeJlyWTE1w9SskTWMruajP7L9xZ0xCb3is=
Message-ID: <feed8cdd05091912362ac13f3e@mail.gmail.com>
Date: Mon, 19 Sep 2005 12:36:15 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: stephen.pollei@gmail.com
To: Nikita Danilov <nikita@clusterfs.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
In-Reply-To: <17197.15183.235861.655720@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432AFB44.9060707@namesys.com>
	 <200509171416.21047.vda@ilport.com.ua>
	 <17197.15183.235861.655720@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Nikita Danilov <nikita@clusterfs.com> wrote:
> Denis Vlasenko writes:
>  > On Friday 16 September 2005 20:05, Hans Reiser wrote:
>  > You can declare functions even if you never use them.
>  > Thus here you can avoid using #if/#endif:
> It's other way around: declaration is guarded by the preprocessor
> conditional so that nobody accidentally use znode_is_loaded() outside of
> the debugging mode.
Except it doesn't disallow someone from using znode_is_loaded, if you
wanted to do that you would have done this....
#if defined(REISER4_DEBUG) || defined(WHATEVER_ELSE)
int znode_is_loaded(const znode * node /* znode to query */ );
#else
#define znode_is_loaded(I_dont_care_you_are_going_to_) \
   } )die(]0now[>anyway<}}}}}}*bye*}
#endif
That way instead of silently(or -Wmissing-prototypes gving a warning)
quessing at a prototype and *maybe* geting a link time error, you get
a nice compile-time bomb-out.

So unless you have -Wmissing-prototypes and -Werror set then your
#if/#endif does very little indeed, especially with the size of kernel
it's easy to ignore yet another warning even if the missing-prototype
warning was set.
And if you would have gotten a link error then that is what you were
really depending on to save your bacon.

P.S. I'd make the define one line if gmail didn't word wrap too much.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
