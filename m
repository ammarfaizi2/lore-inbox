Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbTCGIWD>; Fri, 7 Mar 2003 03:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbTCGIWD>; Fri, 7 Mar 2003 03:22:03 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:30855 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261457AbTCGIV7>; Fri, 7 Mar 2003 03:21:59 -0500
Message-ID: <20030307083226.12083.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: green@namesys.com
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sf.net
Date: Fri, 07 Mar 2003 03:32:25 -0500
Subject: Re: smatch update / 2.5.64 / kbugs.org
X-Originating-Ip: 66.127.101.73
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Drokin <green@namesys.com>
 
> Also is anybody working on "redundant assignments" stuff as described in Standford guys papers?
> 
 
I have been planning to write an equivelence module that
would save what variables where equivelent.  For example ...
a = b = kmalloc();
c = a;
... a, b and c are all equivelent.

The redundant assignment check looks for places that 
assign a variable to an equivelent variable.  You would 
need to check for this anyway as part of writing the 
equivelence module.

The equivelence module has other uses as well ...
a = b = kmalloc();
if (!a) {
        return -ENOMEM;
}
b->foo = bar;

Right now the dereference check prints a false positive
on those, but the equivelence module would fix that.

I don't have the "redundant code" paper in front of me, 
so I forget what other types of things they looked for.

regards,
dan carpenter

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

