Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278593AbRJSSsO>; Fri, 19 Oct 2001 14:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278594AbRJSSsE>; Fri, 19 Oct 2001 14:48:04 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:39121 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278593AbRJSSrs>; Fri, 19 Oct 2001 14:47:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: hps@intermeta.de, "Henning P. Schmiedehausen" <mailgate@hometree.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 20:50:54 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com> <20011018121318.17949@smtp.adsl.oleane.com> <9qomdf$obo$1@forge.intermeta.de>
In-Reply-To: <9qomdf$obo$1@forge.intermeta.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15uegq-0xpVlAC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 09:57, Henning P. Schmiedehausen wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> >>> struct device {
> And a version field! Please add a version field right to the
> beginning. This would make supporting legacy drivers in later versions
> _much_ easier.

IMHO it would be a good idea not to create and fill those structs using a 
function, instead of letting the driver code create the struct or using 
versions. 

In the current version of the patch struct device is allocated using 

struct device *device_alloc_dev(void);

and then later registered using 

int device_register_dev(struct device *dev);


In other words the fields are set by the bus driver. The problem is that when 
somebody adds a new, required field then existing code will silently break. 
So I would propose to think about using something like

struct device *device_create_dev(const char *name,
			const char *bus_id,
			struct device_driver *driver, 
			void *driver_data, 
			void *platform_data,
			u32 current_state);

The advantage is that when you add a new field the old code won't compile 
before it has been fixed. It also allows you to do large changes in the 
underlying code without breaking source compatibility. 
The disadvantage is that you cannot add a field that should be specifier by 
the caller without either adding a new function or destroying source 
compatibility.

bye...

