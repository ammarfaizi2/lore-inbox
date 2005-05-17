Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVEQKjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVEQKjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVEQKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:39:13 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:27213 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261359AbVEQKjH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:39:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LGu4RTtKP8ng0H6MeF+eI1YHlp8GH+acdrqIPYlmJqpW4Zn7sdu3Bo8eHZinydoJPwj0apju4dC2Ca+1EDEIQAGQM30gDB7jiEeTpunCO2zx3cxxirhYtw7vn34U/YxDO0NgUaXl9/c6/DF/z4y+1GtKMwn8uTl3K3X/A4U+310=
Message-ID: <2538186705051703394944e949@mail.gmail.com>
Date: Tue, 17 May 2005 06:39:07 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks) device attribute callbacks - take 2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches implement dynamic sysfs callbacks for
device_attribute, and provide a possible standard sensor attribute
macro for the majority of the i2c sensor chip/hwmon drivers. Finally a
patch against adm1026 shows how the patch can be used to reduce the
footprint and clean up an existing driver.

The new form of dynamic sysfs callback simply passes a reference to
the device_attribute struct, instead of a void *, along the lines of
the suggestion by Russell King (see
http://lkml.org/lkml/2005/5/14/116). Embedding the device_attribute
struct in a custom struct one can use a macro based on container_of to
access the custom attribute specific data.

Although functionally as capable as the void *, this solution I feel
is better in that it rids of some error-prone casting, and the
resulting code seems generally cleaner and easier to understand, there
is also no need for the extra void * member in the base sysfs
attribute. On the other hand a bit more work is required to implement
this on a grand scale, and in many cases a new attribute struct might
have to be defined for a driver, along with any convenience macros. My
example patch implements a new attribute struct
sensor_device_attribute that should be reusable by the majority of i2c
chip drivers (as suggested by Greg).

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani
