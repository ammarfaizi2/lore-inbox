Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVCORvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVCORvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCORuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:50:21 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:64639 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261700AbVCORrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:47:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iki+wdU33HmlJ/1socahbozElJelJrriIcSSa5nULyf+SfWb+pLy21vDSBK1TMfE+MGJusHNVrMfjp9PNl7Yok91VLArjkKAK3DoGJ94TcNBByhFEWFoVY9GG7zYry6d3CxloU4t8FoldY/FxuYiIZbho+mbZPpuBzQi9ZY5kfg=
Message-ID: <d120d500050315094724938ffc@mail.gmail.com>
Date: Tue, 15 Mar 2005 12:47:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] Changes to the driver model class code.
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050315170834.GA25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, 15 Mar 2005 09:08:34 -0800, Greg KH <greg@kroah.com> wrote:

> So I'll be slowly converting the kernel over to using this new
> interface, and when finished, I can get rid of the old class apis (or
> actually, just make them static) so that no one can implement them
> improperly again...

I disagree with this last step. What I liked about the driver model is
that once you convert (properly) subsystem to using it you
automatically get your proper refcounting and memory gets released at
proper time. The change as it proposed disconnects class device
instance from the meat so separate refcounting implementation
isneeded. This increases maintenance costs.

I always viewed class_simple as a stop-gap measure to get hotplug
events in place until proper implementation is done. Please leave the
original interface in place so it can still be used if one wshes to do
so.

And what about device_driver and device structure? Are they going to
be changed over to be separately allocated linked objects? If not then
its enouther reason to keep original class interface - uniformity of
driver model interface.

-- 
Dmitry
