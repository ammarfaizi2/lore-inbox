Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269023AbUIBUfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269023AbUIBUfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUIBUdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:33:53 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:47096 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269043AbUIBUdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:33:18 -0400
Date: Thu, 02 Sep 2004 20:33:10 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: [PATCH 2.6.8.1 0/2] leds: new class for led devices
To: linux-kernel@vger.kernel.org
Message-id: <1094157190l.4235l.2l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-4, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.2.0, SenderIP=146.151.41.63
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to provide an alternative to the current arm  
specific led interface.  This arm interface does not integrate well  
with the device model and sysfs.

We create a new class that drivers can register a leds_properties  
structure with.  Each led that is registered is assigned a number, and  
three attributes are exported to sysfs in /sys/class/leds/1/, /sys/ 
class/leds/2, etc.

color : a read only string attribute that shows the available colors of  
this led.  If it is a multi-color led, then the colors are seperated by  
a "/" (for example "green/blue").

function : a read/write attribute that sets the current function of  
this led.  The available options are

  timer : the led blinks on and off on a timer
  idle : the led turns off when the system is idle and on when not idle
  power : the led represents the current power state
  user : the led is controlled by user space

light : a read/write attribute that allows userspace to see the current  
status of the led.  If function="user" then writing to this attribute  
will change the led on or off.  If function != "user" then writing has  
no effect.
  light is an integer, where 0 means off, 1 means on first color, 2  
means on second color, etc.  (for example, if color="green/blue" then  
light=1 means turn led on to green and if light=2 means turn led on to  
blue.

A device and driver symlink point to the actual driver and such, so any  
extra attributes can also be registered.

Signed-off-by: John Lenz <lenz@cs.wisc.edu>

