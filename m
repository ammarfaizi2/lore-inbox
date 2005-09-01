Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbVIAVVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbVIAVVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVIAVVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:21:37 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:52926 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030389AbVIAVVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:21:36 -0400
From: Grant.Coady@gmail.com
To: Jean Delvare <khali@linux-fr.org>
Cc: Grant.Coady@gmail.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-mm2
Date: Fri, 02 Sep 2005 07:21:13 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <ncoeh19tbs73mgb0387qsv63ltchfsij09@4ax.com>
References: <20050822213021.1beda4d5.akpm@osdl.org> <nnolg1tusrn3q5p8qeorks8vhc3cromj8l@4ax.com> <20050901090338.4b0d72b3.khali@linux-fr.org>
In-Reply-To: <20050901090338.4b0d72b3.khali@linux-fr.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005 09:03:38 +0200, Jean Delvare <khali@linux-fr.org> wrote:

Hi Jean,

>Hi Grant,
>
>> adm9240 i2c still broken, spamming debug with:
>> (...)
>> Aug 23 18:48:40 peetoo kernel: [ 1591.151834] i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
>> Aug 23 18:48:40 peetoo kernel: [ 1591.170515] i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
>> (...)
>> As soon as write sysfs.
>
>This is not the adm9240 driver writing this, but the smbus driver for
>the SMBus chip your ADM9240 chip is connected to. Which driver is it for
>you? lsmod should tell (if not, modprobe i2c-dev && i2cdetect -l
>should.)

root@peetoo:/var/log# modprobe adm9240
root@peetoo:/var/log# sensors
adm9240-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 7000
  2.5V:    +1.51 V  (min =  +0.00 V, max =  +3.32 V)
   -5V:    -5.08 V  (min = -11.66 V, max =  -0.01 V)
  3.3V:    +3.37 V  (min =  +0.00 V, max =  +4.38 V)
    5V:    +5.18 V  (min =  +0.00 V, max =  +6.64 V)
   12V:   +12.31 V  (min =  +0.00 V, max = +15.94 V)
  -12V:   -11.69 V  (min = -28.33 V, max =  -5.14 V)
PS Fan:      0 RPM  (min =    0 RPM, div = 2)
  Temp:    +32.0°C  (high =  +127°C, hyst =  +127°C)
vid:       +2.00 V
alarms:   Chassis intrusion detection                  ALARM

root@peetoo:/sys/bus/i2c/devices/0-002d# echo -e "1\c" > chassis_clear
root@peetoo:/sys/bus/i2c/devices/0-002d# echo -e "1" > chassis_clear

<terminal lockup>

It seems now to be Jon Smirl's stomping sysfs, sorry for noise.

Cheers,
Grant.

