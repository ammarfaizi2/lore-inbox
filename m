Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWINOhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWINOhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWINOhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:37:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:23674 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750823AbWINOhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:37:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=dD3592oV6NCf5GZ03SmZwtvadDZNSpOEzutLY71aaSy2QOqrJETGxqde7ZwOQDmYN2v5oSGzkgm9Q3gWp6jWczjbwyujOtbEn2c+xKvg42Lty3jp5eqsSJ/ztIsSERBf4MCdMZxWWubJ/e+aFH20xkG4z3wbRVwDK7K8EoRqceQ=
Message-ID: <45096912.9010603@gmail.com>
Date: Thu, 14 Sep 2006 18:37:06 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: pm list <linux-pm@lists.osdl.org>
CC: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] PowerOP, Intro 0/2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PowerOP Core provides completely arch independent interface
to create and control operating points which consist of arbitrary
subset of power parameters available on a certain platform.

PowerOP Core upper layer interface provides the following capabilities:
- to register an operating point by passing an identifier of the point
represented by a string and arbitrary subset of power parameters available on a
certain platform by a string (parameter name) and value pairs.
- to unregister operating point by name
- to set operating point by name
- to get values of arbitrary subset of platform power parameters associated
this  a point (point is passed by name or NULL to get current parameter values
from hw)
- _optional_ SysFS interface. If SysFs interface is enabled each operating point
registered with PowerOP core appears under /sys/power/. /sys/power/<op>/ will
contain an attribute for each power parameter. Power parameters are rw. An
operating point may be activated by writing its name to /sys/power/active. The
hardware power parameters currently set may be read via /sys/power/hw/, a
special operating point that reads parameter attribute values from hardware, for
diagnostic purposes.
Operating points creation with help of SysFS interface is _optional_
_configurable_ feature. Operating points are created by writing the name of the
operating point to /sys/power/new.  This may be a job for configfs.


PowerOP get and register point APIs use name/value pairs for the power
parameters which eliminate the need for data structure sharing between
the PM core and consumers of the PowerOP API.   Earlier versions
required include/asm-xxx/power_params.h to be included in both places.

This also enables a variable argument list for the registration and get
APIs.  Some operating points may only need to work with a subset of the
power parameters.  In this case the creator of the operating point only
needs to provide the name/value pair for the parameters required for
that point.  The rest are set to a don't care value by the internals.

PowerOP is a building block for power management on systems that have a
large set of power parameter that can adjusted to maximize power and
operational efficiency.   Mobile consumer devices are examples of these
systems that require the PowerOP features.   However, PowerOP works
just as well on systems with one or two parameters.  The API allows the
h/w layer to define what parameters are available on that platform.

Operating points can be registered at anytime.  Registration can occur
from a architecture init-call, loadable kernel module or some other
layer.  Operating point registration notifiers are provided for layers,
such as cpufreq, that could take advantage of new operating
points that become available or just need to know when operating points
are loaded.

PowerOP continues to support in kernel governor concepts from cpufreq as well
as userspace policy managers.









