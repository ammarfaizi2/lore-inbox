Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSLFMb1>; Fri, 6 Dec 2002 07:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSLFMb1>; Fri, 6 Dec 2002 07:31:27 -0500
Received: from [213.171.53.133] ([213.171.53.133]:20494 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S262416AbSLFMb0>;
	Fri, 6 Dec 2002 07:31:26 -0500
Date: Fri, 6 Dec 2002 15:39:33 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <1421466772557.20021206153933@wr.miee.ru>
To: linux-kernel@vger.kernel.org
CC: Adam Belay <ambx1@neo.rr.com>
Subject: [2.5.50] oops while read accessing to /proc/bus/pnp/escd
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cat /proc/bus/pnp/escd couses an oops.
oops caused while executing this func.
static int __pnp_bios_read_escd(char *data, u32 nvram_base)
{
        u16 status;
        if (!pnp_bios_present())
                return ESCD_FUNCTION_NOT_SUPPORTED;
        status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
                               data, 65536, (void *)nvram_base, 65536);
        return status;
}
but i don't have access to my computer and can't send full oops.
I've tried to solve this problem myself, but couldn't.
I think that the problem is in nvram_base because we don't alocate
memory page for it. We get address from pnp_bios_escd_info, but in PnP
BIOS spec wrote that
  "In this case, it is the responsibility of the caller to construct a
16-bit data segment descriptor with base = NVStorageBase, a limit
of 64K and read/write access."
I didn't find something like memory aloc between getting escd info and
calling this func.
Best regards.
             Ruslan.
PS And please CC patch to me if it'll be fixed before I do it myself.
PS And last, any comments and explanations will be desirable.

