Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289192AbSANNyb>; Mon, 14 Jan 2002 08:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSANNyV>; Mon, 14 Jan 2002 08:54:21 -0500
Received: from pcow058o.blueyonder.co.uk ([195.188.53.98]:56589 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S289192AbSANNyJ>;
	Mon, 14 Jan 2002 08:54:09 -0500
Date: Mon, 14 Jan 2002 13:57:45 +0000
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: IDE code
Message-Id: <20020114135745.671cc624.spyro@armlinux.org>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

in the ide code the functions ide_[input|output]_data() seem to have become
polluted by a test for a 'helper function' to be used to read data instead
of inb() and friends.

It is my opinion that the functions should not have the test and
subroutine, as it violates the 'layering' in that they no longer just 'get
the data' but now also test for ... etc. blah blah.

I propose that we should be using the already existing function pointers to
allow the CALLERS of ide_[input|output]_data() to perform the condition,
and branch if appropriate to a driver provided alternative function.

This would mean replacing the handful (literally) of ide_input_data() and
ide_output_data() calls with a macro (say, IDE_INPUT_DATA()) which performs
the condition, or, if not needed, can be defined away as a straight call to
ide_input_data() etc.

As the writer of an ide card driver that needs this functionality (it uses
a multiply mapped register concept on ARM hardware to take advantage of its
multiple load/store instructions for PIO (the hardware cannot do DMA, its
15 years old :)), I would appreciate input on wether or not anyone else
feels this change should / should not be made?
