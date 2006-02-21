Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932791AbWBUVcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbWBUVcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWBUVcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:32:25 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:44751 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932791AbWBUVcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:32:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mZ9WXA4NxEA33drYqENv8DP6+ZYO5JUhAnECbWgHdFVq301rfzrYtBfoAwH9eYl/mkJ9zjhsczqTxe1stt0YeFSqYnXqpAGQ8M6+cOwMeoIM4XI27dbE/a7dvUTOYg2K8xwN6eboFyVs6SKigluq6N65dELdut0iBjdgecDviyA=
Message-ID: <d120d5000602211332p16381c16t100f93116cd33539@mail.gmail.com>
Date: Tue, 21 Feb 2006 16:32:21 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Suppressing softrepeat
Cc: "Pete Zaitcev" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
In-Reply-To: <20060221210800.GA12102@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221124308.5efd4889.zaitcev@redhat.com>
	 <20060221210800.GA12102@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Feb 21, 2006 at 12:43:08PM -0800, Pete Zaitcev wrote:
>
> > Add the "nosoftrepeat" parameter. This is useful if a "dumb" keyboard
> > has (unswitcheable) hardware repeat, like in Dell DRAC3.
>
> The softrepeat code should properly ignore all autorepeated keys from a
> 'dumb' keyboard. It's rather common that a keyboard we can't communicate
> with is in autorepeat mode, because that's the mode AT keyboards wake up
> in after power on.

Hmm, atkbd only detects "repeated" keystrokes if it is working in
hard-repeat mode:

        value = atkbd->release ? 0 :
                                (1 + (!atkbd->softrepeat &&
test_bit(atkbd->keycode[code], atkbd->dev->key)));

Should we always recognize "repeats"? Then we woudl not need any
workarounds, be it kbdrate or sysfs.

--
Dmitry
