Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263364AbTCNPgi>; Fri, 14 Mar 2003 10:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTCNPgi>; Fri, 14 Mar 2003 10:36:38 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:64659 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263364AbTCNPgb>; Fri, 14 Mar 2003 10:36:31 -0500
Date: Fri, 14 Mar 2003 16:46:42 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonas Holmberg <jonas.holmberg@axis.com>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix stack usage for amd_flash.c
Message-ID: <20030314154642.GC27154@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch reduces the stack usage of amd_flash_probe by a couple of
kByte. The target of freeing the memory after probe should be reached
with __initdata as well. Untested, though.

Is it ok to apply?

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra

--- linux-2.5.64/drivers/mtd/chips/amd_flash.c	Wed Mar 12 14:16:34 2003
+++ linux-2.5.64-i2o/drivers/mtd/chips/amd_flash.c	Thu Mar 13 13:18:10 2003
@@ -417,205 +417,202 @@
 
 
 
-static struct mtd_info *amd_flash_probe(struct map_info *map)
+const __initdata struct amd_flash_info table[] = {
 {
-	/* Keep this table on the stack so that it gets deallocated after the
-	 * probe is done.
-	 */
-	const struct amd_flash_info table[] = {
-	{
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV160DT,
-		.name = "AMD AM29LV160DT",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV160DB,
-		.name = "AMD AM29LV160DB",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_TOSHIBA,
-		.dev_id = TC58FVT160,
-		.name = "Toshiba TC58FVT160",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_FUJITSU,
-		.dev_id = MBM29LV160TE,
-		.name = "Fujitsu MBM29LV160TE",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_TOSHIBA,
-		.dev_id = TC58FVB160,
-		.name = "Toshiba TC58FVB160",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_FUJITSU,
-		.dev_id = MBM29LV160BE,
-		.name = "Fujitsu MBM29LV160BE",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV800BB,
-		.name = "AMD AM29LV800BB",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29F800BB,
-		.name = "AMD AM29F800BB",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV800BT,
-		.name = "AMD AM29LV800BT",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29F800BT,
-		.name = "AMD AM29F800BT",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV800BB,
-		.name = "AMD AM29LV800BB",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_ST,
-		.dev_id = M29W800T,
-		.name = "ST M29W800T",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_ST,
-		.dev_id = M29W160DT,
-		.name = "ST M29W160DT",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_ST,
-		.dev_id = M29W160DB,
-		.name = "ST M29W160DB",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29BDS323D,
-		.name = "AMD AM29BDS323D",
-		.size = 0x00400000,
-		.numeraseregions = 3,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 48 },
-			{ .offset = 0x300000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x3f0000, .erasesize = 0x02000, .numblocks  = 8 },
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29BDS643D,
-		.name = "AMD AM29BDS643D",
-		.size = 0x00800000,
-		.numeraseregions = 3,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 96 },
-			{ .offset = 0x600000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x7f0000, .erasesize = 0x02000, .numblocks  = 8 },
-		}
-	} 
-	};
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV160DT,
+	.name = "AMD AM29LV160DT",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV160DB,
+	.name = "AMD AM29LV160DB",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_TOSHIBA,
+	.dev_id = TC58FVT160,
+	.name = "Toshiba TC58FVT160",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_FUJITSU,
+	.dev_id = MBM29LV160TE,
+	.name = "Fujitsu MBM29LV160TE",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_TOSHIBA,
+	.dev_id = TC58FVB160,
+	.name = "Toshiba TC58FVB160",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_FUJITSU,
+	.dev_id = MBM29LV160BE,
+	.name = "Fujitsu MBM29LV160BE",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV800BB,
+	.name = "AMD AM29LV800BB",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29F800BB,
+	.name = "AMD AM29F800BB",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV800BT,
+	.name = "AMD AM29LV800BT",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29F800BT,
+	.name = "AMD AM29F800BT",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV800BB,
+	.name = "AMD AM29LV800BB",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_ST,
+	.dev_id = M29W800T,
+	.name = "ST M29W800T",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_ST,
+	.dev_id = M29W160DT,
+	.name = "ST M29W160DT",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_ST,
+	.dev_id = M29W160DB,
+	.name = "ST M29W160DB",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29BDS323D,
+	.name = "AMD AM29BDS323D",
+	.size = 0x00400000,
+	.numeraseregions = 3,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 48 },
+		{ .offset = 0x300000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x3f0000, .erasesize = 0x02000, .numblocks  = 8 },
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29BDS643D,
+	.name = "AMD AM29BDS643D",
+	.size = 0x00800000,
+	.numeraseregions = 3,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 96 },
+		{ .offset = 0x600000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x7f0000, .erasesize = 0x02000, .numblocks  = 8 },
+	}
+} 
+};
 
+static struct mtd_info *amd_flash_probe(struct map_info *map)
+{
 	struct mtd_info *mtd;
 	struct flchip chips[MAX_AMD_CHIPS];
 	int table_pos[MAX_AMD_CHIPS];
