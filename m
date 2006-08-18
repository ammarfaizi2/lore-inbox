Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWHRNSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWHRNSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWHRNSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:18:22 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:13446 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751368AbWHRNSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:18:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i4ElXwvDdxRPu3bQpaauWLZ/E+aK44W+5IGWZtyW5XfHEAZKe7RYEvbF6tSMEi72Hx3TVrpLfiAJ/PChPTxhm0Z8jGM72sOsKNKc5VvHsSlVPBcA6uR3umFCJj5OrSKyqJAQu/oDstqB7kdnRhX+J+40/fhVrPOPa5jOwZB9cec=
Message-ID: <6bffcb0e0608180618m13153b26yb8c3151c30265be@mail.gmail.com>
Date: Fri, 18 Aug 2006 15:18:20 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Question about handling return value of device_create_file function
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed that sparse generates a lot of "ignoring return value
of 'device_create_file'" warnings.

(cat sparse.txt | grep -c "device_create_file"
1231 :)

I want to fix this warnings, but I'm wondering how to properly handle
return value of device_create_file function.

The shortest way.

int foo()
{
	int error;

	[..]

	error = device_create_file(&bar, &bas)

	if (error)
		return error;
}

A bit longer way.

int foo()
{
	int error;

	[..]

	error = device_create_file(&bar, &bas)

	if (error) {
		subsystem_remove_device(bar);
		return error;
	}
}

Any hints?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
