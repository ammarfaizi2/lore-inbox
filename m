Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279988AbRKIS27>; Fri, 9 Nov 2001 13:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279994AbRKIS2u>; Fri, 9 Nov 2001 13:28:50 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:13235 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S279988AbRKIS2j>;
	Fri, 9 Nov 2001 13:28:39 -0500
Date: Fri, 09 Nov 2001 15:28:56 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: 2.2.19 causing looping oops
Message-ID: <13290000.1005319736@araucaria>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a manually decoded oops from 2.2.19 - the top of the
oops ran off the serial console buffer (sigh) and there was nothing
in the files, so I decoded the stack manually with 'ksymoops -A'
on every stack entry. This gives a looping stack like below
(I've this is a representative sample from the end of the oops
output. Note the last section is the only but with the mmput
in.

Any idea what could cause this (& why it didn't just Oops
once, and stop). I presume it continued in a cyclic manner
until the stack filled up and then everything died.


Adhoc c0109208 <error_code+34/40>           <------- LOOP END HERE
Adhoc c0116e0c <exit_notify+1c/1dc>
Adhoc c01171fa <do_exit+22e/274>
Adhoc c0109614 <die_if_no_fixup+0/40>
Adhoc c01df5f6 <tvecs+eb6/36c0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e8c4 <do_page_fault+2c4/3b0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e600 <do_page_fault+0/3b0>        <------- LOOP START HERE
Adhoc c0109208 <error_code+34/40>           <------- LOOP END HERE
Adhoc c0116e0c <exit_notify+1c/1dc>
Adhoc c01171fa <do_exit+22e/274>
Adhoc c0109614 <die_if_no_fixup+0/40>
Adhoc c01df5f6 <tvecs+eb6/36c0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e8c4 <do_page_fault+2c4/3b0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e600 <do_page_fault+0/3b0>
Adhoc c0109208 <error_code+34/40>           <------- LOOP START HERE
Adhoc c01171c0 <do_exit+1f4/274>            <------- LOOP END HERE (*)
Adhoc c0109614 <die_if_no_fixup+0/40>
Adhoc c01df5f6 <tvecs+eb6/36c0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e8c4 <do_page_fault+2c4/3b0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e600 <do_page_fault+0/3b0>
Adhoc c0109208 <error_code+34/40>           <------- LOOP START
Adhoc c011276c <mmput+4/34>                 <------- HERE
Adhoc c011708c <do_exit+c0/274>
Adhoc c0109614 <die_if_no_fixup+0/40>
Adhoc c01df5f6 <tvecs+eb6/36c0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e8c4 <do_page_fault+2c4/3b0>
Adhoc c01e112e <tvecs+29ee/36c0>
Adhoc c010e600 <do_page_fault+0/3b0>

(*)=this cycle a little different - note do_exit+1f4

--
Alex Bligh
