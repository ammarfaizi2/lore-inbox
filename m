Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVLUTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVLUTnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVLUTnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:43:03 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:9116 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932434AbVLUTnC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:43:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CPruSaPdV44aOw6kjinlBwF+sGTEb8hv2PIWJ7C8EJQSe68AjxmRzxJzR4iCcCD2MmpVKnS0CkOrWLvWS1t/mnSeH6RbDE3LGFaF1KcZKE0pTlhbhtzXe7mcf6x+xrA+Ta6QfjysuopA6xxu1pvaQO51iucsmFeloWM2W7Nho0E=
Message-ID: <d120d5000512211143ge189479qf1916741479586b4@mail.gmail.com>
Date: Wed, 21 Dec 2005 14:43:01 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051221105001.226178f1@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051220214511.12bbb69c@inspiron>
	 <200512202101.39498.dtor_core@ameritech.net>
	 <20051221105001.226178f1@inspiron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> On Tue, 20 Dec 2005 21:01:39 -0500
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
>
> > > +if (ops->read_time) {
> > > +memset(tm, 0, sizeof(struct rtc_time));
> > >
> >
> > What guarantees that ops is not NULL here? Userspace can keep the
> > attribute (file) open and issue read after class_device was unregistered
> > and devdata set to NULL.
>
>  Right. For /proc and /dev there's a try_module_get(ops->owner) in place.
>
>  Should I add it to every rtc_sysfs_show_xxx or there's
>  a better way to do it?
>

Well, I don't know what will it buy you: if ops is NULL
try_module_get(ops->owner) will OOPS just as happily as original code.

Your class_device has to hold on to all data structures that are
referenced from sysfs attributes untils its ->release() function is
called. Alternatively you could stuck a mutex and a flag somewhere in
driver data and take it when unregistering class device and also in
all attributes (and chech the flag there).

--
Dmitry
