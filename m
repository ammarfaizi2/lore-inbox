Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280432AbRJaTTR>; Wed, 31 Oct 2001 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280430AbRJaTTH>; Wed, 31 Oct 2001 14:19:07 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:5783 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280432AbRJaTSw>;
	Wed, 31 Oct 2001 14:18:52 -0500
Date: Wed, 31 Oct 2001 19:19:26 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: 2xQ: Is PM + ACPI but /no/ APM a valid configuration? Interrupts
 enabled in APM set power state?
Message-ID: <1234072342.1004555966@[10.132.113.67]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to debug power management on an IBM T23.

No PM, no ACPI, no APM

suspend works - i.e. doesn't crash on resume,
but 'dumbly' and doesn't restore some PCI states
(unsurprising), clock, etc., and no /proc/apm
etc.

PM, no ACPI, no APM

this seems to work, but debugging the power management
stuff suggests that the PCI drivers are never sent
suspend or resume events, which is causing the
crashes below.

PM, ACPI, no APM

This is the wierd one. I get a pile of scrolly
messages which I think is ACPI debugging
and appear to be uninterruptible - SysRq K crashes
the machine. They are attached at the bottom.

Is this a valid configuration? I can't see why
not.

PM, no ACPI, APM

Machine hangs on resume.

printk()s tell me that it successfully does
all the pm_send stuff, then calls apm_set_power_state()
(I can see this immediately before the LCD disappears).
But on resume, though the LCD comes back on, it
never gets to the printk() I inserted immediately
afterwards.

PM, ACPI, APM

as above

Also, on advice, I have APM configured to allow
interrupts (IBM laptop). So what happens if a
device interrupts as / because of the resume,
perhaps before the segment registers have
been restored, and certainly before the pm_send
stuff has gone around?

[kernel 2.4.12-ac5 at present]

--
Alex Bligh

...
dswexec-0421 [07] Ds_exec_end_op
  : [Store]: Could not resolve operands, AE_NOT_EXIST
evregion-0218 [16] Ev_address_space_dispa
  : no handler for region (c1b74108) [Embedded Control]
exfldio-0224 [15] Ex_read_field_datum
  : Region Embedded_control(3) has no handler
dswexec-0421 [07] Ds_exec_end_op
  : [Store]: Could not resolve operands, AE_NOT_EXIST
evregion-0218 [16] Ev_address_space_dispa
  : no handler for region (c1b74108) [Embedded Control]
exfldio-0224 [15] Ex_read_field_datum
  : Region Embedded_control(3) has no handler
dswexec-0421 [07] Ds_exec_end_op
  : [Store]: Could not resolve operands, AE_NOT_EXIST
evregion-0218 [16] Ev_address_space_dispa
  : no handler for region (c1b74108) [Embedded Control]
exfldio-0224 [15] Ex_read_field_datum
  : Region Embedded_control(3) has no handler
dswexec-0421 [07] Ds_exec_end_op
  : [Store]: Could not resolve operands, AE_NOT_EXIST
evregion-0218 [16] Ev_address_space_dispa
  : no handler for region (c1b74108) [Embedded Control]
exfldio-0224 [15] Ex_read_field_datum
  : Region Embedded_control(3) has no handler
... etc.
--
Alex Bligh
