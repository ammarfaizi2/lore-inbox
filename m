Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161383AbWJYUzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbWJYUzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161387AbWJYUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:55:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:8404 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161383AbWJYUzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:55:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=k2FnMlfiwHGluj8FLcTZXSJlBgpojMLPpVCimOyr4T5J0xS+gUeMFqp2XJO5eqH7fwEtbaDNKg3Nn8gWkdoXOvD0jDYsYxrZYkccBGaxt4diZCSNUlS5B4ongyGVsg9FA8F6/YjpDFPW7nUEW8Ff29Zhq9/UyYL9lkfo1kCFJSA=
Message-ID: <d120d5000610251355n4104e3b8l6a86cb91a27c08eb@mail.gmail.com>
Date: Wed, 25 Oct 2006 16:55:13 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Greg.Chandler@wellsfargo.com" <Greg.Chandler@wellsfargo.com>
Subject: Re: Touchscreen hardware hacking/driver hacking.
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D020C69E4@msgswbmnmsp25.wellsfargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C69E4@msgswbmnmsp25.wellsfargo.com>
X-Google-Sender-Auth: dcf6994ff4834781
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 10/25/06, Greg.Chandler@wellsfargo.com <Greg.Chandler@wellsfargo.com> wrote:
>
> I've been thinking about the code I added:
>        {
>                .ident = "FLORA-ie 55mi",
>                .matches = {
>                        DMI_MATCH(DMI_PRODUCT_NAME, "FLORA-ie 55mi"),
>                },
>        },
>
> That's nice and all that it works

Great!

> but I'd like to make it work for all
> models.  Some don't return the same strings, but do have the same
> hardware.  I noticed the same thing with your lifebook models.
> I can't find the definition for "DMI_MATCH"

inlude/linux/dmi.h

>, of if I did, I sure don't
> understand it.  What I'd like to do is something along the lines of:
>
> const char* UPCASEME(string str)
>  {
>    for (int x = 0; x < str.size(); x = x + 1)
>      {
>        str[x] = toupper(str[x]);
>      }
>    return str.c_str();
>  }
>
> {
>  if (strncmp(UPCASEME(DMI_PRODUCT_NAME), UPCASEME("FLORA-ie ") ,9) ==
> 0)

DMI_PRODUCT_NAME is number of field in DMI tables containing product
name, it is a number and can't be upcased ;)

<...skip...>
> int dmi_check_system(struct dmi_system_id *list)
>
> If this is true, maybe that function should be changed to make it
> case-insensitive?
> If so then, 4 of the pre-existing cases can be summed up as "LifeBook
> B", and all of the Flora-ie tablets can be listed as a single entry as
> well.
>
> I know somone will object to this as a dangerous assumption that all
> models, or all spellings are the same.  Byt the time the flames hit, I
> should have my asbestos armour out and ready.  However, I know for a
> fact that all of the Hitachi tablets do have this, and for what I have
> read so do the lifebooks.  My opinion is that "it's only a PS/2" driver,
> what could go wrong.

It was considered but we decided that if we need to rely on solely DMI
data when activating some features we need to add models one by one
and do not use "blanket" options. There are lifebooks out there that
do not have that kind of outscreen so if we tried to match just on
"LIFEBOOK" present in the product name we might hit such models and
then their PS/2 mice would not work.

If we knew of a way to query the touchscreen for lifebook protocol
support that would be a different story...

-- 
Dmitry
