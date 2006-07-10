Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWGJT6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWGJT6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWGJT6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:58:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:41909 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422687AbWGJT6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:58:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=TIQDKp7r1VOWpCHbyGiibB4gYRK+OjIWFOQaXj/lggiWXxp/3inJvajg3CTr1AzgFpud/tOkYYLiHdxbSbeFlykTLWwYJ3xC0CHNoMkHjmP9jBTkB5xbBuezGjEOJdiJE23rUVhmm7tcEuuJXEnuRQiTLz6znyBaJBEbErkLwpA=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Mon, 10 Jul 2006 12:58:32 -0700
User-Agent: KMail/1.8.1
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <20060708132856.41644999.zaitcev@redhat.com>
In-Reply-To: <20060708132856.41644999.zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607101258.34005.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 08 July 2006 13:28, you wrote:
> The decision to cripple the devio in this way was conscious. The problem
> scenario with 2.4.27 and earlier was how many devices would fail if
> a control and other transfer were submitted simultaneously. In other
> words, when desktop components (e.g. HAL) rescanned /proc/bus/usb/devices,
> some other devices would throw errors. The most notorious example
> would be TEAC CD-210PU, because of how widespread and popular it is.
>
> In other words, I crippled your application for the sake of a bunch
> of users of other devices. You have to realize though, that your
> concerns weren't voiced in the time and it was widely believed that
> user-mode drivers did not submit several URBs at once (primarily
> because the queueing in HCDs of 2.4 was a suspect).

I understand your decision but this does not follow the USB spec. According 
to the spec, two threads should be able to perform operations on the same 
device at the same time.

> But it seems to me that the best approach would be if you made
> a special case for bulk+bulk and locked out control transfers somehow.

This is exactly what I suggested in my first email. It just involves adding a 
couple of lines of code, but I'm not sure how the unlock function works in 
2.4. In 2.6, the device is unlocked WITHIN proc_bulk before usb_bulk_mesg is 
called and is locked after usb_bulk_mesg returns. Therefore, the device is 
still locked during control transfers.

Thanks,

Ben
